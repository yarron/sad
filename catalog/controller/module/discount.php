<?php  
class ControllerModuleDiscount extends Controller {
	protected function index() {
		$this->language->load('module/discount');
        
        $this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_logged'] = sprintf($this->language->get('text_logged'),  $this->customer->getFirstName());

		$this->data['text_url_discount'] = $this->language->get('text_url_discount');
        $this->data['text_date_end'] =  $this->config->get('discount_date_end')
            ? sprintf($this->language->get('text_date_end'),  date("d.m.y", strtotime($this->config->get('discount_date_end'))))
            : '';
		
 		$this->data['button_url_discount'] = $this->url->link('information/discount');
		$this->id       = 'login';
		
        $this->load->model('total/discount');
	    $this->data['text_description'] = array();

	    if ($this->config->get('discount_date_end')) {
            $this->data['status'] = (strtotime("now") < strtotime($this->config->get('discount_date_end'))) && $this->config->get('discount_status');
        } else {
            $this->data['status'] = $this->config->get('discount_status');
        }


		$discounts = array();
		
        $discounts = $this->model_total_discount->getDiscounts();
        foreach($discounts as $disc){
            $this->data['text_description'][] = sprintf($this->language->get('text_description'), (int) $disc['percent']."%", (int) $disc['price']);
        }


		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/discount.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/discount.tpl';
        
		} else {
            $this->template = 'default/template/module/discount.tpl';
        }
		
		$this->render();
		
	}
}
?>