<?php 
class ControllerInformationDiscount extends Controller {
	public function index() {
		$this->language->load('total/discount');
        
        $this->document->setTitle($this->language->get('heading_title_d'));  
        $this->data['heading_title_d'] = $this->language->get('heading_title_d');
        $this->data['not_discounts'] = $this->language->get('not_discounts');
        $this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),        	
        	'separator' => false
      	);

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title_d'),
			'href'      => $this->url->link('information/discount'),
        	'separator' => $this->language->get('text_separator')
      	);	
			
        $this->data['description_all']  = $this->config->get('discount_description');    
        
        $this->data['description'] = $this->data['description_all'][(int)$this->config->get('config_language_id')];
        
        $this->load->model('total/discount');
		 
		$this->data['discounts'] = array();
		
		$this->data['discounts'] = $this->model_total_discount->getDiscounts();
        $this->data['text_date_end'] =  $this->config->get('discount_date_end')
            ? date("d.m.y", strtotime($this->config->get('discount_date_end')))
            : '';

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/discount.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/discount.tpl';
		} else {
			$this->template = 'default/template/information/discount.tpl';
		}
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/footer',
			'common/header'
		);
        			
		$this->response->setOutput($this->render());	
		
  	}
	
		
}
?>