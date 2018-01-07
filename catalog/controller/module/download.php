<?php
class ControllerModuleDownload extends Controller {
	protected function index($setting) {
        static $module = 0;

        $this->language->load('module/download');
 
      	$this->data['heading_title'] = $this->config->get('download_settings')['category_name'];
        $this->data['tooltip_download'] = $this->language->get('tooltip_download');

        $this->load->model('catalog/product');
		$this->data['downloads'] = $this->model_catalog_product->getDownloads();
        $this->data['categories'] = $this->config->get('download_categories');
        $this->data['scripts'] = '$("#prices_module ul").accordion({header : "> li > a.kids", active : "none", collapsible : true, autoHeight: false});';

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