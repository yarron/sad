<?php 
class ControllercheckoutRobosuccess extends Controller { 
	public function index() { 
	
		if( $this->config->get('robokassa_premod_success_page_type') != 'custom' )
		{
			$this->session->data['redirect'] = $this->url->link('checkout/success', '', 'SSL');

			$this->redirect($this->url->link('checkout/success', '', 'SSL'));
		}
		
		/* start robokassa */
		$VERSION = VERSION;
		$VERSION = str_replace(".", "", $VERSION);
		
		if( strlen($VERSION) == 3 )
		{
			$VERSION .= '0';
		}
		elseif( strlen($VERSION) > 4 )
		{
			$VERSION = substr($VERSION, 0, 4);
		}		
		/* end robokassa */
	
		$ORDER_ID = '';
		
		if( isset($this->session->data['order_id']) ) 
		$ORDER_ID = $this->session->data['order_id'];
		elseif( isset($this->session->data['last_order_id']) )
		$ORDER_ID = $this->session->data['last_order_id'];
	
		if( $VERSION >= 1540 &&  $VERSION < 1550  )
		{
			if ( isset($this->session->data['order_id']) && ( !empty($this->session->data['order_id']))  ) {
				$this->session->data['last_order_id'] = $this->session->data['order_id'];
			}
		}
	
	
		$this->cart->clear();
			
		if( isset($this->session->data['shipping_method']) )
		unset($this->session->data['shipping_method']);
			
		if( isset($this->session->data['shipping_methods']) )
		unset($this->session->data['shipping_methods']);
			
		if( isset($this->session->data['payment_method']) )
		unset($this->session->data['payment_method']);
			
		if( isset($this->session->data['payment_methods']) )
		unset($this->session->data['payment_methods']);
			
		if( isset($this->session->data['guest']) )
		unset($this->session->data['guest']);
			
		if( isset($this->session->data['comment']) )
		unset($this->session->data['comment']);
			
		if( isset($this->session->data['order_id']) )
		unset($this->session->data['order_id']);	
			
		if( isset($this->session->data['coupon']) )
		unset($this->session->data['coupon']);
			
		if( $VERSION > 1512 )
		{
			if( isset($this->session->data['reward']) )
			unset($this->session->data['reward']);
		}
			
		if( isset($this->session->data['voucher']) )
		unset($this->session->data['voucher']);
			
		if( isset($this->session->data['vouchers']) )
		unset($this->session->data['vouchers']);
		
									   
		$this->language->load('checkout/success');
		
		$ar = unserialize( $this->config->get('robokassa_premod_success_page_header') );
		$heading_title = $ar[ $this->config->get('config_language') ];
		$heading_title = str_replace("{number}", $ORDER_ID, $heading_title);
		
		$this->document->setTitle( $heading_title );
    	$this->data['heading_title'] = $heading_title;
		
		$this->data['breadcrumbs'] = array(); 

      	$this->data['breadcrumbs'][] = array(
        	'href'      => $this->url->link('common/home'),
        	'text'      => $this->language->get('text_home'),
        	'separator' => false
      	); 
		
      	$this->data['breadcrumbs'][] = array(
        	'href'      => $this->url->link('checkout/cart'),
        	'text'      => $this->language->get('text_basket'),
        	'separator' => $this->language->get('text_separator')
      	);
				
		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('checkout/checkout', '', 'SSL'),
			'text'      => $this->language->get('text_checkout'),
			'separator' => $this->language->get('text_separator')
		);	
					
      	$this->data['breadcrumbs'][] = array(
        	'href'      => $this->url->link('checkout/success'),
        	'text'      => $this->language->get('text_success'),
        	'separator' => $this->language->get('text_separator')
      	);
		
		$ar = unserialize( $this->config->get('robokassa_premod_success_page_text') );
		$this->data['text_message'] = $ar[ $this->config->get('config_language') ];
		
		$this->data['text_message'] = str_replace("{number}", $ORDER_ID, $this->data['text_message']);
		
    	$this->data['button_continue'] = $this->language->get('button_continue');

    	$this->data['continue'] = $this->url->link('common/home');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/success.tpl';
		} else {
			$this->template = 'default/template/common/success.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'			
		);
				
		$this->response->setOutput($this->render());
  	}
}
?>