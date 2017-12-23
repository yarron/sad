<?php /* robokassa metka */
class ControllerPaymentRobokassa8 extends Controller {

	private $INDEX = 8;

	
	protected function index() {
		
		$STORE_ID = $this->config->get('config_store_id');
		
		$this->load->model('localisation/currency');
		$currencies = $this->model_localisation_currency->getCurrencies();
		
		$CONFIG = array();
		
		if( $STORE_ID )
		{
			$CONFIG['robokassa_test_mode'] = $this->config->get('robokassa_test_mode_store');
			$CONFIG['robokassa_password1'] = $this->config->get('robokassa_password1_store');
			$CONFIG['robokassa_shop_login'] = $this->config->get('robokassa_shop_login_store');
			$CONFIG['robokassa_currency'] = $this->config->get('robokassa_currency_store');
			$CONFIG['robokassa_currencies'] = $this->config->get('robokassa_currencies_store');
			$CONFIG['robokassa_commission'] = $this->config->get('robokassa_commission_store');
			$CONFIG['robokassa_confirm_status'] = $this->config->get('robokassa_confirm_status_store');
			$CONFIG['robokassa_interface_language'] = $this->config->get('robokassa_interface_language_store');
			$CONFIG['robokassa_default_language'] = $this->config->get('robokassa_default_language_store');
			$CONFIG['robokassa_desc'] = $this->config->get('robokassa_desc_store');
			$CONFIG['robokassa_desc'] = $CONFIG['robokassa_desc'][ $this->config->get('config_language') ];
			
			foreach($CONFIG as $key=>$value)
			{
				if( $this->is_serialized($value) )
				$value = unserialize($value);
				
				if( isset( $value[$STORE_ID] ) )
				$CONFIG[$key] = $value[$STORE_ID];
				else
				$CONFIG[$key] = '';
			}
		}
		else
		{
			$CONFIG['robokassa_test_mode'] = $this->config->get('robokassa_test_mode');
			$CONFIG['robokassa_password1'] = $this->config->get('robokassa_password1');
			$CONFIG['robokassa_shop_login'] = $this->config->get('robokassa_shop_login');
			$CONFIG['robokassa_currency'] = $this->config->get('robokassa_currency');
			$CONFIG['robokassa_currencies'] = $this->config->get('robokassa_currencies');
			$CONFIG['robokassa_commission'] = $this->config->get('robokassa_commission');
			$CONFIG['robokassa_confirm_status'] = $this->config->get('robokassa_confirm_status');
			$CONFIG['robokassa_interface_language'] = $this->config->get('robokassa_interface_language');
			$CONFIG['robokassa_default_language'] = $this->config->get('robokassa_default_language');
			$CONFIG['robokassa_desc'] = $this->config->get('robokassa_desc');
			$CONFIG['robokassa_desc'] = $CONFIG['robokassa_desc'][ $this->config->get('config_language') ];
			
			
			foreach($CONFIG as $key=>$value)
			{
				if( $this->is_serialized($value) )
				$value = unserialize($value);
				
				$CONFIG[$key] = $value;
			}
		}
		
		
		$RUB = '';
		
		if( !isset($currencies['RUB']) && !isset($currencies['RUR']) ){}
		elseif( isset($currencies['RUB']) ) $RUB = 'RUB';
		elseif( isset($currencies['RUR']) ) $RUB = 'RUR';
		
	
		$this->data['button_confirm'] = $this->language->get('button_confirm');
		
		$this->load->model('checkout/order');
		
		$order_info = array();
		
		//exit( $this->cart->customer );
		
		
		
		if( !empty($this->session->data['order_id']) )
		{
			$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
			$order_info['name'] = $order_info['firstname'].' '.$order_info['lastname'];
		}
		else 
		{
			$order_info['total'] = $this->cart->getTotal();
			$order_info['store_name'] = $this->config->get('config_name');
			$order_info['store_url'] = $_SERVER['HTTP_HOST'];
			$order_info['name'] = '';
			$order_info['email'] = '';
		}
		
		$LINK = array();
		$URL = '';
		
		if( $CONFIG['robokassa_test_mode'] )
		{
			$URL = "http://test.robokassa.ru/Index.aspx";
		}
		else
		{
			$URL = "https://auth.robokassa.ru/Merchant/Index.aspx";
		}
		
		$mrh_pass1 = $CONFIG['robokassa_password1'];
		$LINK['MrchLogin'] = $CONFIG['robokassa_shop_login'];
		
		
		
		
		$mrh_login = $LINK['MrchLogin'];
		
		$out_summ = $order_info['total'];
				
		if( $this->config->get('config_currency')!=$CONFIG['robokassa_currency'] ) 
		{
			$out_summ = $this->currency->convert($out_summ, $this->config->get('config_currency'), $CONFIG['robokassa_currency']);
		}
		elseif( $this->currency->getValue($CONFIG['robokassa_currency']) != 1 )
		{
			$out_summ = $this->currency->getValue($CONFIG['robokassa_currency']) * $out_summ;
		}
		
		
		$robokassa_currencies = $CONFIG['robokassa_currencies'];
		if( $robokassa_currencies[$this->INDEX] == 'robokassa' )
		$robokassa_currencies[$this->INDEX] = '';
		$LINK['IncCurrLabel'] = $robokassa_currencies[$this->INDEX];
		
		if( $CONFIG['robokassa_commission'] == 'shop' && !$CONFIG['robokassa_test_mode'] )
		{
			$url = 'http://merchant.roboxchange.com/WebService/Service.asmx/CalcOutSumm?MerchantLogin='.$mrh_login.
					'&IncCurrLabel='.$LINK['IncCurrLabel'].'&IncSum='.$out_summ;
			
			#echo $url;
			
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
			//<OutSum>93.200000</OutSum>
			
			if( $page && preg_match("/<OutSum>([\d\.]+)<\/OutSum>/", $page, $ar) )
			{
				if( !empty($ar[1]) )
				{
					$out_summ = $ar[1];
				}
			}
		}
		
		$shp_item = "2";
		
		
		$this->data['robokassa_confirm_status'] = $CONFIG['robokassa_confirm_status'];
		
		$in_curr = $robokassa_currencies[$this->INDEX];
		
		if( !empty($this->session->data['order_id']) )
		$inv_id =  $this->session->data['order_id'];
		else
		$inv_id = 0;
		
		$LINK['OutSum'] = $out_summ;
		
		if( !empty($this->session->data['order_id']) )
		$LINK['InvId'] =  $this->session->data['order_id'];
		else
		$LINK['InvId'] = 0;
		

		$LINK['Desc'] = $CONFIG['robokassa_desc'];
		$LINK['Desc'] = str_replace("{number}", $LINK['InvId'], $LINK['Desc']);
		$LINK['Desc'] = str_replace("{siteurl}", $order_info['store_url'], $LINK['Desc']);
		$LINK['Desc'] = str_replace("{name}", $order_info['name'], $LINK['Desc']);
		
		$LINK['SignatureValue'] = sha1("$mrh_login:$out_summ:$inv_id:$mrh_pass1:Shp_item=$shp_item");
		$LINK['Shp_item'] = $shp_item;
		$LINK['Email'] = $order_info['email'];
		
		$culture = $this->session->data['language'];
		
		if( $CONFIG['robokassa_interface_language'] && $CONFIG['robokassa_interface_language']!='detect' )
		{
			$culture = $CONFIG['robokassa_interface_language'];
		}
		elseif( $CONFIG['robokassa_interface_language']=='detect' )
		{
			if( $this->session->data['language'] == 'ru' || $this->session->data['language']=='en' )
			{
				$culture = $this->session->data['language'];
			}
			elseif( $CONFIG['robokassa_default_language'] )
			{
				$culture = $CONFIG['robokassa_default_language'];
			}
			else
			{
				$culture = 'ru';
			}
		}
		else
		{
			if( $culture!='en' )
			{
				$culture!='ru';
			}
		}
		
		$LINK['Culture'] = $culture;
		
		$this->data['robokassa_link'] = $URL.'?'.http_build_query($LINK);
		
		if( $this->config->get('robokassa_premod_success_page_type') == 'custom' && 
			$this->config->get('robokassa_confirm_status') == 'premod' )
		$this->data['continue'] = $this->url->link('checkout/robosuccess');
		else
    	$this->data['continue'] = $this->url->link('checkout/success');
		
		$this->data['MrchLogin'] = $LINK['MrchLogin'];
		$this->data['OutSum'] = $LINK['OutSum'];
		$this->data['InvId'] = $LINK['InvId'];
		$this->data['Desc'] = $LINK['Desc'];
		$this->data['SignatureValue'] = $LINK['SignatureValue'];
		$this->data['Shp_item'] = $LINK['Shp_item'];
		$this->data['IncCurrLabel'] = $LINK['IncCurrLabel'];
		$this->data['Culture'] = $LINK['Culture'];
		$this->data['Email'] = $LINK['Email'];
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/robokassa.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/payment/robokassa.tpl';
		} else {
			$this->template = 'default/template/payment/robokassa.tpl';
		}		
		
		$this->render();
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