<?php

class ControllerInformationGallery extends Controller {

	public function index() {
	    $this->data['gallery_info'] = null;
    	$this->language->load('information/gallery');
	    $this->load->model('design/banner');

		$this->data['breadcrumbs'] = array();
	
		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home'),
			'text'      => $this->language->get('text_home'),
			'separator' => false
		);
	
		if (isset($this->request->get['gallery_id'])) {
			$gallery_id = $this->request->get['gallery_id'];
		} else {
			$gallery_id = 0;
		}

		if ($gallery_id) {
		    
		    $gallery_info = $this->model_design_banner->getGallery($gallery_id);  
            $gallery_image = $this->model_design_banner->getBanner($gallery_id);

            if (!isset($gallery_info['name'])) {
            	return;
			}

			$this->data['breadcrumbs'][] = array(
				'href'      => $this->url->link('information/gallery'),
				'text'      => $this->language->get('heading_title'),
				'separator' => $this->language->get('text_separator')
			);
		
			$this->data['breadcrumbs'][] = array(
				'href'      => $this->url->link('information/gallery', 'gallery_id=' . $this->request->get['gallery_id']),
				'text'      => $gallery_info['name'],
				'separator' => $this->language->get('text_separator')
			);
			
			$this->document->setTitle($gallery_info['meta_title']);
			$this->document->setDescription($gallery_info['meta_description']);
            $this->document->addScript('catalog/view/javascript/jquery/tabs.js');
            $this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');
            $this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');

     		$this->data['gallery_info'] = $gallery_info;
     		$this->data['heading_title'] = $gallery_info['name'];
			$this->data['description'] = html_entity_decode($gallery_info['description']);

            $this->load->model('tool/image');
            $this->data['banners'] = array();

            foreach ($gallery_image as $result) {
                $images = array();
				if (file_exists(DIR_IMAGE . $result['image'])) {

                    $images[] = array(
                        'popup' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'),'',true),
                        'thumb' => $this->model_tool_image->resize($result['image'], 170, 128)
                    );

                    $this->data['banners'][] = array(
						'title' => $result['title'],
						'link'  => $result['link'],
                        'images'=> $images
					);
				}
			}
            //print_r($this->data['banners']); die();
     		$this->data['button_news'] = $this->language->get('button_news');
			$this->data['button_continue'] = $this->language->get('button_continue');
			$this->data['gallery'] = $this->url->link('information/gallery');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/gallery.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/information/gallery.tpl';
			} else {
				$this->template = 'default/template/information/gallery.tpl';
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
		
	  	} else {
		
		    	$url = '';
			
				if (isset($this->request->get['page'])) {
				$page = $this->request->get['page'];
				$url .= '&page=' . $this->request->get['page'];
				} else { 
				$page = 1;
				}
				
				$limit = $this->config->get('config_catalog_limit');
		
				$data = array(
    				'page' => $page,
    				'limit' => $limit,
    				'start' => $limit * ($page - 1),
				);
		
				$total = $this->model_design_banner->getTotalGallery();
		
				$pagination = new Pagination();
				$pagination->total = $total;
				$pagination->page = $page;
				$pagination->limit = $limit;
				$pagination->text = $this->language->get('text_pagination');
				$pagination->url = $this->url->link('information/gallery', $url . '&page={page}', 'SSL');
		
				$this->data['pagination'] = $pagination->render();
		
	  		    $gallery_data = $this->model_design_banner->getGalleryAll($data);



	  		if ($gallery_data) {
			
				$this->document->setTitle($this->language->get('heading_title'));
			
				$this->data['breadcrumbs'][] = array(
					'href'      => $this->url->link('information/gallery'),
					'text'      => $this->language->get('heading_title'),
					'separator' => $this->language->get('text_separator')
				);
			
				$this->data['heading_title'] = $this->language->get('heading_title');

				$this->data['text_more'] = $this->language->get('text_more');
	
				$chars = 600;
				$this->load->model('tool/image');

				foreach ($gallery_data as $result) {
                    $images = array();
                    $gallery_image = $this->model_design_banner->getGalleryImage($result['banner_id']);
                    foreach($gallery_image as $image){
                        $images[] = $this->model_tool_image->resize($image['image'], 120,90);
                    }

					$this->data['gallery_data'][] = array(
						'id'  				=> $result['banner_id'],
						'name'        		=> $result['name'],
                        'name'        		=> $result['name'],
						'description'  	    => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $chars),
						'href'         		=> $this->url->link('information/gallery', 'gallery_id=' . $result['banner_id']),
                        'images'            => $images
					);
				}
			
				$this->data['button_continue'] = $this->language->get('button_continue');
			
				$this->data['continue'] = $this->url->link('common/home');
			
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/gallery.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/information/gallery.tpl';
				} else {
					$this->template = 'default/template/information/gallery.tpl';
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
			
	    	} else {
			
		  		$this->document->setTitle($this->language->get('text_error'));
			
	     		$this->document->breadcrumbs[] = array(
	        		'href'      => $this->url->link('information/gallery'),
	        		'text'      => $this->language->get('text_error'),
	        		'separator' => $this->language->get('text_separator')
	     		);
			
				$this->data['heading_title'] = $this->language->get('text_error');
			
				$this->data['text_error'] = $this->language->get('text_error');
			
				$this->data['button_continue'] = $this->language->get('button_continue');
			
				$this->data['continue'] = $this->url->link('common/home');
			
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
				} else {
					$this->template = 'default/template/error/not_found.tpl';
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
	}
}
?>
