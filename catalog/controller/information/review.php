<?php 
class ControllerInformationReview extends Controller {
	private $error = array(); 
	    
  	public function index() {
		$this->language->load('information/review');

    	$this->document->setTitle($this->language->get('heading_title'));  

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),        	
        	'separator' => false
      	);

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('information/review'),
        	'separator' => $this->language->get('text_separator')
      	);	
			
    	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['entry_name'] = $this->language->get('entry_name');
    	$this->data['entry_enquiry'] = $this->language->get('entry_enquiry');
        $this->data['text_wait'] = $this->language->get('text_wait');
        
    	$this->data['button_continue'] = $this->language->get('button_post');
    
		$this->data['action'] = $this->url->link('information/review');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/review.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/review.tpl';
		} else {
			$this->template = 'default/template/information/review.tpl';
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

	public function write() {
		$this->language->load('information/review');
		
		$this->load->model('catalog/review');
		
		$json = array();
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 32)) {
				$json['error'] = $this->language->get('error_name');
			}
 
			if ((utf8_strlen($this->request->post['enquiry']) < 10) || (utf8_strlen($this->request->post['enquiry']) > 3000)) {
				$json['error'] = $this->language->get('error_enquiry');
			}
	
			if (!isset($json['error'])) {
				$this->model_catalog_review->addReview($this->request->post);
				
				$json['success'] = $this->language->get('text_success');
			}
		}
		
		$this->response->setOutput(json_encode($json));
	}
    
    public function review() {
    	$this->language->load('information/review');
		
		$this->load->model('catalog/review');

		$this->data['text_on'] = $this->language->get('text_on');
		$this->data['text_no_reviews'] = $this->language->get('text_no_reviews');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}  
		
		$this->data['reviews'] = array();
		
		$review_total = $this->model_catalog_review->getTotalReviews();
		
		$results = $this->model_catalog_review->getReviews(($page - 1) * 10, 10);
      		
		foreach ($results as $result) {
        	$this->data['reviews'][] = array(
        		'author'     => $result['author'],
				'text'       => $result['text'],
        		'reviews'    => sprintf($this->language->get('text_reviews'), (int)$review_total),
        		'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
        	);
      	}			
			
		$pagination = new Pagination();
		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = 10; 
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('information/review/review', 'page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/review.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/product/review.tpl';
		} else {
			$this->template = 'default/template/product/review.tpl';
		}
		
		$this->response->setOutput($this->render());
	}
}
?>
