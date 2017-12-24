<?php 
class ControllerTotalDiscount extends Controller { 
	private $error = array(); 
	
    public function install() {
		$this->load->model('sale/discount');
		$this->model_sale_discount->createModuleTables();	
	}
     
	public function index() { 
		$this->load->language('total/discount');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		
        $this->data['heading_title'] = $this->language->get('heading_title');
        
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
            $this->model_setting_setting->editSetting('discounts', $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		
        $this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
        
        $this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort');
        $this->data['entry_date_start'] = $this->language->get('entry_date_start');
        $this->data['entry_date_end'] = $this->language->get('entry_date_end');
        $this->data['entry_description_head'] = $this->language->get('entry_description_head');
        $this->data['entry_description_end'] = $this->language->get('entry_description_end');
        $this->data['entry_sub_description_head'] = $this->language->get('entry_sub_description_head');
        $this->data['entry_sub_description_end'] = $this->language->get('entry_sub_description_end');
        
        //������ ������ ��� ����������
        $this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
 	    $this->data['button_modulator'] = $this->language->get('button_modulator');
        
        //������������ ������, ���� ����
        if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
        
        
        //������������ ������� ������
        $this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_total'),
			'href'      => $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('total/discount', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
        
        $this->data['action'] = $this->url->link('total/discount', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['modulator'] = $this->url->link('total/discount/modulator', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['token'] = $this->session->data['token'];
		
        if (isset($this->request->post['discount_description'])) {
			$this->data['discount_description'] = $this->request->post['discount_description'];
		} else {
			$this->data['discount_description'] = $this->config->get('discount_description');
		}
  
        if (isset($this->request->post['discount_status'])) {
			$this->data['discount_status'] = $this->request->post['discount_status'];
		} else {
			$this->data['discount_status'] = $this->config->get('discount_status');
		}
        if (isset($this->request->post['discount_sort_order'])) {
			$this->data['discount_sort_order'] = $this->request->post['discount_sort_order'];
		} else {
			$this->data['discount_sort_order'] = $this->config->get('discount_sort_order');
		}
        if (isset($this->request->post['discount_date_start'])) {
            $this->data['discount_date_start'] = $this->request->post['discount_date_start'];
        } else {
            $this->data['discount_date_start'] = $this->config->get('discount_date_start');
        }
        if (isset($this->request->post['discount_date_end'])) {
            $this->data['discount_date_end'] = $this->request->post['discount_date_end'];
        } else {
            $this->data['discount_date_end'] = $this->config->get('discount_date_end');
        }
        
        $this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->template = 'total/discount.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
    
   	private function getForm($action, $discount_info = Array()) {
   	    $this->data['heading_title'] = $this->language->get('heading_title_'.$action);
        
   	    //������������ ������, ���� ����
        if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
        
        if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
		}
        
        if (isset($this->error['price'])) {
			$this->data['error_price'] = $this->error['price'];
		} else {
			$this->data['error_price'] = '';
		}
        
        if (isset($this->error['percent'])) {
			$this->data['error_percent'] = $this->error['percent'];
		} else {
			$this->data['error_percent'] = '';
		}
        
        //������������ ������� ������
        $this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_total'),
			'href'      => $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('total/discount', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
        $this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title_'.$action),
			'href'      => $this->url->link('total/discount/'.$action, 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

        $this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
        
        $this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		
		$this->data['entry_status'        ] = $this->language->get('entry_status');
		$this->data['entry_sort_order'    ] = $this->language->get('entry_sort');

        $this->data['entry_price'    ]      = $this->language->get('entry_price');
        $this->data['entry_sub_price'    ] = $this->language->get('entry_sub_price');
        $this->data['entry_percent'    ]      = $this->language->get('entry_percent');
        $this->data['entry_sub_percent'    ] = $this->language->get('entry_sub_percent');
        $this->data['entry_description'] = $this->language->get('entry_description');
        $this->data['entry_sub_description'] = $this->language->get('entry_sub_description');
        $this->data['entry_name'] = $this->language->get('entry_name');

        $this->data['cancel'] = $this->url->link('total/discount/modulator', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['token'] = $this->session->data['token'];
        
        $this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

        if (isset($this->request->post['discount_description'])) {
			$this->data['discount_description'] = $this->request->post['discount_description'];
		} elseif (!empty($discount_info)) {
			$this->data['discount_description'] = $this->model_sale_discount->getDiscountDescriptions($this->request->get['discount_id']);
		} else {
			$this->data['discount_description'] = array();
		}
        
       	if (isset($this->request->post['name'])) {
      		$this->data['name'] = $this->request->post['name'];
    	} elseif (!empty($discount_info)) {
			$this->data['name'] = $discount_info['name'];
		} else {	
      		$this->data['name'] = '';
    	}

        if (isset($this->request->post['sort_order'])) {
      		$this->data['sort_order'] = $this->request->post['sort_order'];
    	} elseif (!empty($discount_info)) {
			$this->data['sort_order'] = $discount_info['sort_order'];
		} else {
      		$this->data['sort_order'] = '';
    	}
        
        if (isset($this->request->post['status'])) {
      		$this->data['status'] = $this->request->post['status'];
    	} elseif (!empty($discount_info)) {
			$this->data['status'] = $discount_info['status'];
		} else {
      		$this->data['status'] = '';
    	}
        
        if (isset($this->request->post['price'])) {
      		$this->data['price'] = $this->request->post['price'];
    	} elseif (!empty($discount_info)) {
			$this->data['price'] = $discount_info['price'];
		} else {
      		$this->data['price'] = '';
    	}
        
        if (isset($this->request->post['percent'])) {
      		$this->data['percent'] = $this->request->post['percent'];
    	} elseif (!empty($discount_info)) {
			$this->data['percent'] = $discount_info['percent'];
		} else {
      		$this->data['percent'] = '';
    	}
        

        if (!isset($this->request->get['discount_id'])) {
			$this->data['action'] = $this->url->link('total/discount/insert', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$this->data['action'] = $this->url->link('total/discount/update', 'token=' . $this->session->data['token'] . '&discount_id=' . $this->request->get['discount_id'], 'SSL');
		}


        $this->template = 'total/discount_'.$action.'.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
        
   	}
        
   	public function modulator() { 
  	    $this->load->language('total/discount');

		$this->document->setTitle($this->language->get('heading_title_mod'));
		
		$this->load->model('setting/setting');

		$this->data['heading_title'] = $this->language->get('heading_title_mod');
        
        //������������ ������, ���� ����
        if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
        if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
        //������������ ������� ������
        $this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_total'),
			'href'      => $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('total/discount', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
        $this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title_mod'),
			'href'      => $this->url->link('total/discount/modulator', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
        
   		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		$this->data['column_action'] = $this->language->get('column_action');
        $this->data['column_price'] = $this->language->get('column_price');
        $this->data['column_percent'] = $this->language->get('column_percent');
        $this->data['column_status'] = $this->language->get('column_status');
        
        $this->data['button_insert'] = $this->language->get('button_insert');		
		$this->data['button_delete'] = $this->language->get('button_delete');
        $this->data['button_back']   = $this->language->get('button_back');
        
        $this->data['text_enabled']  = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_no_results'] = $this->language->get('text_no_results');
        $this->data['text_action'] = $this->language->get('text_edit');
        
        $this->data['insert'] = $this->url->link('total/discount/insert', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['delete'] = $this->url->link('total/discount/delete', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['back'] = $this->url->link('total/discount/', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['update'] = $this->url->link('total/discount/update', 'token=' . $this->session->data['token'], 'SSL');

       	$this->load->model('sale/discount');
        
        $this->data['discounts'] = $this->model_sale_discount->getDiscounts(0);
      
        $this->template = 'total/discount_mod.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());  
   	}
    
    public function insert(){
        $this->load->language('total/discount');

		$this->document->setTitle($this->language->get('heading_title_insert'));
		
		$this->load->model('sale/discount');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_sale_discount->addDiscount($this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('total/discount/modulator', 'token=' . $this->session->data['token'], 'SSL'));
		}

        $this->getForm("insert");
    }
    
    public function delete(){
        $this->load->language('total/discount');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/discount');
        
        if (isset($this->request->post['selected']) && $this->validate()) {
			foreach ($this->request->post['selected'] as $discount_id) {
				$this->model_sale_discount->deleteDiscount($discount_id);
			}
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('total/discount/modulator', 'token=' . $this->session->data['token'], 'SSL'));
		}
        $this->modulator();
		
    }
    
    public function update(){
        $this->load->language('total/discount');

		$this->document->setTitle($this->language->get('heading_title_update'));
		
		$this->load->model('sale/discount');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            
            $this->model_sale_discount->editDiscount($this->request->get['discount_id'],$this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('total/discount/modulator', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$discount_info = '';
        //���������� ������ �� ����
        if (isset($this->request->get['discount_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$discount_info = $this->model_sale_discount->getDiscount($this->request->get['discount_id']);
    	}
        
        $this->getForm("update", $discount_info);

    }
    
	private function validate() {
	   
		if (!$this->user->hasPermission('modify', 'total/discount')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
    
   	private function validateForm() {

    	if (!$this->user->hasPermission('modify', 'total/discount')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}

    	if ( ((strlen(utf8_decode($this->request->post['name']))) < 3) || ((strlen(utf8_decode($this->request->post['name']))) > 64)) {
      		$this->error['name'] = $this->language->get('error_name');
    	}
		
        if (empty($this->request->post['price']) || (!is_numeric($this->request->post['price']))) {
      		$this->error['price'] = $this->language->get('error_price');
    	}
        
        if (empty($this->request->post['percent']) || (!is_numeric($this->request->post['percent']))) {
      		$this->error['percent'] = $this->language->get('error_percent');
    	}
        
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}
}
?>