<?php
class ControllerModuleDownload extends Controller {
	protected function index($setting) {

        static $module = 0;

        $this->data['setting'] = $this->config->get('download_setting');

        $this->language->load('module/download');
 
      	$this->data['heading_title'] = $this->language->get('heading_title');
        $this->data['text_category'] = $this->language->get('text_category');
        $this->data['text_download'] = $this->language->get('text_download');
        $this->data['text_all_category'] = $this->language->get('text_all_category');
		$this->data['button_download'] = $this->language->get('button_download');
		
		$this->load->model('catalog/product');
		$this->load->model('catalog/category');

		$this->data['downloads'] = $this->model_catalog_product->getDownloads();
        $this->data['categories'] = $this->model_catalog_category->getCategories(0, false);
        
        $this->data['href'] = $this->url->link('product/product/download', 'download_id=');
        $this->data['module'] = $module++;
        
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/download.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/download.tpl';
		} else {
			$this->template = 'default/template/module/download.tpl';
		}

		$this->render();
	}
}
?>