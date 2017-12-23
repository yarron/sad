<?php  

class ControllerModuleCategoryAccordion extends Controller {
	private $cat = array();
    protected function index($settings) {
		$this->language->load('module/category');
		
    	$this->data['heading_title'] = $this->language->get('heading_title');
							
		$this->load->model('catalog/category');
		$this->load->model('catalog/product');
        if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts[0] = 0;
		}
        
        
		//ACCORDION
		$this->data['categories'] = $this->getCategoriesAccordion(0);
        $this->data['special'] = $this->getSpecial();
        $active="none";
        foreach($this->cat as $k=>$value){
            if($value == $parts[0]){
                $active = $k;
                break;
            }
        }
        
        if($active !== "none")
		  $this->data['scripts'] = '$("#multi_display ul").accordion({header : "> li > a.kids", active : '.$active.', collapsible : true, autoHeight: false});';
        else
          $this->data['scripts'] = '$("#multi_display ul").accordion({header : "> li > a.kids", active : "none", collapsible : true, autoHeight: false});';
          
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/category_accordion.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/category_accordion.tpl';
		} else {
			$this->template = 'default/template/module/category_accordion.tpl';
		}
		
		$this->render();
  	}
  	
	private function getSpecial(){
        $this->language->load('module/category_accordion');
        $output = '<ul>';
        $output .= '<li><a href="' . $this->url->link("product/special") . '" style="font-size:13px;font-weight: bold;">' . $this->language->get('heading_special') . '</a></li>';
        $output .= '</ul>';
    
		return $output;
    }
	private function getCategoriesAccordion($parent_id, $current_path = '') {
		

        $results = $this->model_catalog_category->getCategories($parent_id);
        
		$output = '<ul>';
		
		foreach ($results as $result) {
		    if($parent_id == 0){
		       $this->cat[] = $result['category_id'];
		    }
			if (!$current_path) {
				$new_path = $result['category_id'];
			} else {
				$new_path = $current_path . '_' . $result['category_id'];
			}
            
			$children = $this->model_catalog_category->getCategories($result['category_id']);
			if($result['top'])
                $caturl = $this->url->link("information/portal", "path=" . $new_path);
            else 
                $caturl = $this->url->link("product/category", "path=" . $new_path);
			
            if (empty($children)) {
				$output .= '<li><a href="' . $caturl . '">' . $result['name'] . '</a></li>';
			} else {
				$output .= '<li><a class="kids" href="' . $caturl . '">' . $result['name'] . '</a>';
				$output .= $this->getCategoriesAccordion($result['category_id'], $new_path);
				$output .= '</li>';
			}
		}
		
		$output .= '</ul>';
    
		return $output;
	}
}
?>