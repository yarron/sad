<?php
class ControllerModuleDownload extends Controller {
	private $error = array(); 

	private function my_sort_array($a, $b)
    {
        if ($a['sort_order'] > $b['sort_order']) {
            return 1;
        } else if ($a['sort_order'] < $b['sort_order']) {
            return -1;
        }
        return 0;
    }

	public function index() {   
		$this->load->language('module/download');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            // print_r( $this->request->post); die();
            $this->model_setting_setting->editSetting('download', $this->request->post);		

			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
        $this->data['text_category'] = $this->language->get('text_category');
        $this->data['text_download'] = $this->language->get('text_download');
        $this->data['text_all_category'] = $this->language->get('text_all_category');
        $this->data['text_no_download'] = $this->language->get('text_no_download');
        $this->data['text_sort_order'] = $this->language->get('text_sort_order');

        $this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
        $this->data['entry_category'] = $this->language->get('entry_category');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
        $this->data['button_add_category'] = $this->language->get('button_add_category');
        $this->data['button_remove_category'] = $this->language->get('button_remove_category');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

        if (isset($this->error['category_root'])) {
            $this->data['error_category_root'] = $this->error['category_root'];
        } else {
            $this->data['error_category_root'] = '';
        }

 		if(isset($this->error['category'])) {
            $this->data['error_category'] = array();
            foreach($this->error['category'] as $k=>$value) {
                if (isset($this->error['category'][$k])) {
                    $this->data['error_category'][$k] = $this->error['category'][$k];
                } else {
                    $this->data['error_category'][$k] = '';
                }
            }
        }


  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/download', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/download', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['setting'] = array();
		
		if (isset($this->request->post['download_settings'])) {
			$this->data['setting'] = $this->request->post['download_settings'];
		} elseif ($this->config->get('download_settings')) {
			$this->data['setting'] = $this->config->get('download_settings');
		} else{
		    $this->data['setting'] = array();
		}

        $this->data['download_categories'] = array();

        if (isset($this->request->post['download_categories'])) {
            $this->data['categories'] = $this->request->post['download_categories'];
        } elseif ($this->config->get('download_categories')) {
            $this->data['categories'] = $this->config->get('download_categories');
            usort($this->data['categories'], array($this, "my_sort_array"));
        } else{
            $this->data['categories'] = array();
        }

        $this->data['modules'] = array();
		
		if (isset($this->request->post['download_module'])) {
			$this->data['modules'] = $this->request->post['download_module'];
		} elseif ($this->config->get('download_module')) { 
			$this->data['modules'] = $this->config->get('download_module');
		}		

		$this->load->model('design/layout');
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

        $this->load->model('catalog/download');
		$this->data['downloads'] = $this->model_catalog_download->getDownloads();

		$this->template = 'module/download.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/download')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		$category_root_length = strlen(utf8_decode($this->request->post['download_settings']['category_name']));
        if ( $category_root_length < 3 || $category_root_length > 64) {
            $this->error['category_root'] = $this->language->get('error_name');
        }

        foreach($this->request->post['download_categories'] as $k=>$category) {
            $category_length = strlen(utf8_decode($category['category']));

            if ( $category_length < 3 || $category_length > 64) {
                if(!isset($this->error['category'][$k])) {
                    $this->error['category'] = array();
                }
                $this->error['category'][$k] = $this->language->get('error_name');
            }
        }



		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}


?>