<?php

class ControllerInformationPortal extends Controller {
    private $_name = 'informations';
   
	public function index() {
	
    	$this->language->load('information/portal');
	    $this->load->model('catalog/category');   
		$this->load->model('catalog/portal');
        
		$this->data['breadcrumbs'] = array();
		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home'),
			'text'      => $this->language->get('text_home'),
			'separator' => false
		);
	
		if (isset($this->request->get['information_id'])) {
			$information_id = $this->request->get['information_id'];
		} else {
			$information_id = 0;
		}
	    
        //пробуем извлечь статью   
		$information_info = $this->model_catalog_portal->getNewsStory($information_id);
	    
        //если статья есть, то открываем её, иначе открываем список статей 
		if ($information_info) $this->getInformation($information_info);
        else $this->getList();
	}
    
    //парсинг пути для выяснения конечной категории
    private function parsePath(){
        $url ='';
        if (isset($this->request->get['path'])) { //если путь существует
            $path = '';
			$parts = explode('_', (string)$this->request->get['path']);
			$category_id = (int)array_pop($parts);

			foreach ($parts as $path_id) {
                
                if (!$path) {
					$path = (int)$path_id;
				} else {
					$path .= '_' . (int)$path_id;
				}
									
				$category_info = $this->model_catalog_category->getCategory($path_id);
				if ($category_info) {
	       			$this->data['breadcrumbs'][] = array(
   	    				'text'      => $category_info['name'],
						'href'      => '',
        				'separator' => $this->language->get('text_separator')
        			);
                    
				}
			}		
		} else $category_id = 0;
        
        return $category_id;
    }
    
    //показать статьи искомой категории
    private function showArticles($data,$category_info){
        $information_data = $this->model_catalog_portal->getNews($data);
	
  		if ($information_data) {
		    $this->data['customtitle'] = $this->language->get('heading_title');

			$this->document->addStyle('catalog/view/javascript/jquery/panels/main.css');
			$this->document->addScript('catalog/view/javascript/jquery/panels/utils.js');
		
			$this->data['text_more'] = $this->language->get('text_more');
			$this->data['text_posted'] = $this->language->get('text_posted');
			
			$chars = $this->config->get('news_headline_chars');
		
			foreach ($information_data as $result) {
				$this->data['information_data'][] = array(
					'id'  		   => $result['information_id'],
					'title'        => $result['title'],
					'description'  => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $chars),
					'href'         => $this->url->link('information/portal', 'information_id=' . $result['information_id'].'&path='.$this->request->get['path']),
					'posted'       => date($this->language->get('date_format_short'), strtotime($result['date_added']))
				);
			}
		
			$this->data['button_continue'] = $this->language->get('button_continue');
			$this->data['continue'] = $this->url->link('common/home');
        }
        else{
            $this->data['text_error'] = $this->language->get('text_error_inf');
        }
        
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/portal.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/portal.tpl';
		} else {
			$this->template = 'default/template/information/portal.tpl';
		}
	
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);
        $this->response->addHeader('Last-Modified: '.gmdate('D, d M Y H:i:s \G\M\T', strtotime($category_info["date_modified"])));		
        $this->response->setOutput($this->render()); 
    }
    
    //список статей
    private function getList(){
        $category_id = $this->parsePath();
        
        //извлекаем искомую категорию
        $category_info = $this->model_catalog_category->getCategory($category_id);
	        
        //если категория есть, то формируем ее данные
        if ($category_info) { 
			if ($category_info['seo_title']) {
		  		$this->document->setTitle($category_info['seo_title']);
			} else {
		  		$this->document->setTitle($category_info['name']);
			}

			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);
			$this->document->addScript('catalog/view/javascript/jquery/jquery.total-storage.min.js');
			
			if ($category_info['seo_h1']) {
				$this->data['heading_title'] = $category_info['seo_h1'];
			} else {
				$this->data['heading_title'] = $category_info['name'];
			}
			
			$this->data['text_refine'] = $this->language->get('text_refine');
			$this->data['text_empty'] = $this->language->get('text_empty');			
			$this->data['text_limit'] = $this->language->get('text_limit');
			$this->data['button_continue'] = $this->language->get('button_continue');
	        
            $this->data['breadcrumbs'][] = array(
				'text'      => $category_info['name'],
				'href'      => $this->url->link('information/portal', 'path=' . $this->request->get['path']),
				'separator' => $this->language->get('text_separator')
			);
            
            $this->load->model('tool/image'); 
              
			if ($category_info['image']) {
				$this->data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
				$this->document->setOgImage($this->data['thumb']);
			} else {
				$this->data['thumb'] = '';
			}
									
			$this->data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');

		    $url = '';
            //если существует параметр page
    		if (isset($this->request->get['page'])) {
    			$page = $this->request->get['page'];
    			$url .= '&page=' . $this->request->get['page'];
    		} else  $page = 1;

            $limit = $this->config->get('config_catalog_limit'); //лимит статей
			$total = $this->model_catalog_portal->getTotalNews($category_id);
	
            //формируем пагинацию
			$pagination = new Pagination();
			$pagination->total = $total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('information/portal', $url . '&page={page}', 'SSL');
	
			$this->data['pagination'] = $pagination->render();
            
            //формируем массив данный для поиска статей   
			$data = array(
				'page'          => $page,
				'limit'         => $limit,
				'start'         => $limit * ($page - 1),
                'category_id'   => $category_id,
			);
		    $this->showArticles($data, $category_info);	//выводим статьи  
    	} else { //если пути нет, то выводим ошибку
	  		
              $this->document->setTitle($this->language->get('text_error'));
     		$this->data['breadcrumbs'][] = array(
        		'href'      => $this->url->link('information/portal'),
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
    
    //открытие статьи
    private function getInformation($information_info){
        $category_id = $this->parsePath();
        $category_info = $this->model_catalog_category->getCategory($category_id);
		if ($category_info) {
   			$this->data['breadcrumbs'][] = array(
				'text'      => $category_info['name'],
				'href'      => $this->url->link('information/portal', 'path=' . $this->request->get['path']),
				'separator' => $this->language->get('text_separator')
			);
            
		}
        $this->document->addStyle('catalog/view/theme/default/stylesheet/news.css');
		$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');
	
		$this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');

		if(isset($this->request->get['path'])){
			$href = '&path='.$this->request->get['path'];
		} else {
            $href = '';
		}

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('information/portal', 'information_id=' . $this->request->get['information_id'].$href),
			'text'      => $information_info['title'],
			'separator' => $this->language->get('text_separator')
		);
		
		$this->document->setTitle($information_info['title']);
		$this->document->setDescription($information_info['meta_description']);
		$this->document->setKeywords($information_info['meta_keyword']);
		$this->document->addLink($this->url->link('information/portal', 'information_id=' . $this->request->get['information_id']), 'canonical');
	
 		$this->data['information_info'] = $information_info;
	
 		$this->data['heading_title'] = $information_info['title'];
 		
		$this->data['description'] = html_entity_decode($information_info['description']);
		
 		$this->data['meta_keyword'] = html_entity_decode($information_info['meta_keyword']);

 		$this->data['button_news'] = $this->language->get('button_news');
		$this->data['button_continue'] = $this->language->get('button_continue');

        if(isset($this->request->get['path'])){
            $href = 'path='.$this->request->get['path'];
        } else {
            $href = '';
        }

		$this->data['news'] = $this->url->link('information/portal',$href);
		$this->data['continue'] = $this->url->link('common/home');
		
		if (isset($_SERVER['HTTP_REFERER'])) 
		      $this->data['referred'] = $_SERVER['HTTP_REFERER'];
		
		$this->data['refreshed'] = 'http://' . $_SERVER['HTTP_HOST'] . '' . $_SERVER['REQUEST_URI'];

	
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/portal.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/portal.tpl';
		} else {
			$this->template = 'default/template/information/portal.tpl';
		}
	
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);
	    $this->response->addHeader('Last-Modified: '.gmdate('D, d M Y H:i:s \G\M\T', strtotime($information_info["date_modified"])));			
		$this->response->setOutput($this->render());
    }
}
?>
