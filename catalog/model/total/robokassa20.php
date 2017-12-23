<?php
class ModelTotalRobokassa20 extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) 
	{		
		$ar = array();
		if( isset($this->session->data['payment_method']) && 
			preg_match("/^robokassa([\d]*)/", $this->session->data['payment_method']['code'], $ar) 
			&&	(
				$this->config->get('robokassa_dopcost') || 
				$this->config->get('robokassa_dopcosttype') == 'comission'
			)
		)  
		{
			$title = $this->session->data['payment_method']['title'];
			
			$STORE_ID = $this->config->get('config_store_id');
		
			$CONFIG = array();
		
			if( $STORE_ID )
			{
				$CONFIG['robokassa_dopcostname'] = $this->config->get('robokassa_dopcostname_store');
				$CONFIG['robokassa_dopcost'] = $this->config->get('robokassa_dopcost_store');
				$CONFIG['robokassa_dopcosttype'] = $this->config->get('robokassa_dopcosttype_store');
			
				
				foreach($CONFIG as $key=>$value)
				{
					if( $this->is_serialized($value) )
					$value = unserialize($value);
				
					$CONFIG[$key] = $value;
				}
				
				$CONFIG['robokassa_dopcostname'] = $CONFIG['robokassa_dopcostname'][ $this->config->get('config_language') ];

			}
			else
			{
				$CONFIG['robokassa_dopcostname'] = $this->config->get('robokassa_dopcostname');
				$CONFIG['robokassa_dopcost'] = $this->config->get('robokassa_dopcost');
				$CONFIG['robokassa_dopcosttype'] = $this->config->get('robokassa_dopcosttype');
			
				
				foreach($CONFIG as $key=>$value)
				{
					if( $this->is_serialized($value) )
					$value = unserialize($value);
				
					$CONFIG[$key] = $value;
				}
				
				$CONFIG['robokassa_dopcostname'] = $CONFIG['robokassa_dopcostname'][ $this->config->get('config_language') ];
			}
			
			
			if( $CONFIG['robokassa_dopcosttype'] == 'comission' && 
				$this->config->get('robokassa_commission') == 'j'  )
			{
				$CONFIG['robokassa_dopcost'] = 5;
			}
			elseif( $CONFIG['robokassa_dopcosttype'] == 'comission' && 
					$this->config->get('robokassa_commission') != 'j' )
			{
				$ID = '';
				if( empty($ar[1]) ) $ID = 0;
				else $ID = $ar[1];
				
				$robokassa_currencies = unserialize( $this->config->get('robokassa_currencies') );
				
				if( empty($robokassa_currencies[ $ID ]) ) return;
				$currency = $robokassa_currencies[ $ID ];
				
				if( empty($currency) ) return;
				
				// ----
				
				$this->load->model('localisation/currency');
				$currencies = $this->model_localisation_currency->getCurrencies();
		
				$RUB = '';
		
				if( !isset($currencies['RUB']) && !isset($currencies['RUR']) ) return;
				elseif( isset($currencies['RUB']) ) $RUB = 'RUB';
				elseif( isset($currencies['RUR']) ) $RUB = 'RUR';
				
				$ratesHash = $this->getRatesHash();
				$rubTotal = $this->currency->convert($total, $this->config->get('config_currency'), $RUB);
				
				$totalWithComission = $this->getRate($rubTotal, $currency);
				
				if( $totalWithComission==0 ) return;
				
				$rubTotalWithComission = $totalWithComission;
				
				if( isset( $ratesHash[ $currency ] ) && $ratesHash[ $currency ] !=1 )
				{
					#echo $ratesHash[ $currency ]." * ".$totalWithComission."<br>";
					$rubTotalWithComission = $ratesHash[ $currency ] * $totalWithComission;
				}
				
				#exit($rubTotalWithComission.' - '.$rubTotal);
				
				$rubCost = $rubTotalWithComission - $rubTotal;
				
				$CONFIG['robokassa_dopcost'] = $this->currency->convert($rubCost, $RUB, $this->config->get('config_currency'));
				$CONFIG['robokassa_dopcosttype'] = 'int';
			}
			
			
			$cost = 0;
			
			if( $CONFIG['robokassa_dopcost'] )
			{
			
				if( $CONFIG['robokassa_dopcosttype'] == 'int' )
				{
					$cost = $CONFIG['robokassa_dopcost'];
				}
				elseif( $CONFIG['robokassa_dopcosttype'] == 'percent'  )
				{
					$cost = round( ($total * $CONFIG['robokassa_dopcost'] / 100), 2 );
				}
				else
				{
					$cost = $this->getPercCost($total, $CONFIG['robokassa_dopcost']);
				}
			}
			
			
			if( !empty($CONFIG['robokassa_dopcostname']) )
			$title = $CONFIG['robokassa_dopcostname'];
		
			$total_data[] = array( 
				'code'       => 'robokassa20',
        		'title'      => $title,
        		'text'       => $this->currency->format($cost),
        		'value'      => $cost,
				'sort_order' => $this->config->get('robokassa_sort_order')
			);
			
			$total += $cost;
		}			
	}
	
	
	
	private function getPercCost($base, $percent)
	{
		$percent = 5;
		
		$res_cost = 0;
		
		for($i=0; $i<10; $i++)
		{
			$bp = $base * $percent / 100;
			
			$res_cost += $bp;
			
			$base = $bp;
		}
		
		return round($res_cost, 2);
	}
	
	
	
	private function getRate($rubTotal, $currency)
	{
		$out_summ = 0;
		$url = "https://merchant.roboxchange.com/WebService/Service.asmx/GetRates?MerchantLogin=".
				$this->config->get('robokassa_shop_login')."&IncCurrLabel=&OutSum=".$rubTotal."&Language=ru";
				
		if( extension_loaded('curl') )
		{
			$c = curl_init($url);
			curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
			$page = curl_exec($c);
			curl_close($c);
		}
		else
		{
			$page = file_get_contents($url);
		}
		
		$ar = array();
		
				//echo $page."<hr>\n\n\n";
				//exit("/<Currency Label=\"".$currency."\" Name=\"[^\"]+\">[^<]*<Rate IncSum=\"([\d\.]+)\"\/>[^<]*<\/Currency>/");
				
		if( $page && preg_match("/<Currency Label=\"".$currency."\" Name=\"[^\"]+\">[^<]*<Rate IncSum=\"([\d\.]+)\"/", $page, $ar) )
		{
			if( !empty($ar[1]) )
			{
				$out_summ = $ar[1];
			}
		}
		else
		{
			return 0;
		}
		
		return $out_summ;
	}		
	
	function getRatesHash() 
	{
		$HASH = array();
		$url = "https://merchant.roboxchange.com/WebService/Service.asmx/GetRates?MerchantLogin=demo&IncCurrLabel=&OutSum=1000&Language=ru";
		
		if( extension_loaded('curl') )
		{
			$c = curl_init($url);
			curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
			$page = curl_exec($c);
			curl_close($c);
		}
		else
		{
			$page = file_get_contents($url);
		}
		
		$ar = explode("<Currency ", $page);
		
		for($i=1; $i<count($ar); $i++)
		{
			$a = array();
			preg_match("/Label=\"([^\"]+)\"/", $ar[$i], $a);
			
			$b = array();
			preg_match("/IncSum=\"([^\"]+)\"/", $ar[$i], $b);
			
			 
			$HASH[ $a[1] ] = 1000 / $b[1];
		}
			
		$HASH['W1R'] = 1;
			
		return $HASH;
	}
	
	protected function is_serialized( $data ) {
    // if it isn't a string, it isn't serialized
		if ( !is_string( $data ) )
        return false;
		$data = trim( $data );
		if ( 'N;' == $data )
        return true;
		if ( !preg_match( '/^([adObis]):/', $data, $badions ) )
        return false;
		switch ( $badions[1] ) {
        case 'a' :
        case 'O' :
        case 's' :
            if ( preg_match( "/^{$badions[1]}:[0-9]+:.*[;}]\$/s", $data ) )
                return true;
            break;
        case 'b' :
        case 'i' :
        case 'd' :
            if ( preg_match( "/^{$badions[1]}:[0-9.E-]+;\$/", $data ) )
                return true;
            break;
		}
		return false;
	}
}
?>