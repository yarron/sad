<?php

class ModelCatalogPortal extends Model { 

	public function getNewsStory($information_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "information n 
        LEFT JOIN " . DB_PREFIX . "information_description nd ON (n.information_id = nd.information_id) 
        LEFT JOIN " . DB_PREFIX . "information_to_store n2s ON (n.information_id = n2s.information_id) 
        WHERE n.information_id = '" . (int)$information_id . "' 
        AND nd.language_id = '" . (int)$this->config->get('config_language_id') . "' 
        AND n2s.store_id = '" . (int)$this->config->get('config_store_id') . "' 
        AND n.status = '1'");
	
		return $query->row;
	}

	public function getNews($data) {
		$sql = "SELECT * FROM " . DB_PREFIX . "information n 
        LEFT JOIN " . DB_PREFIX . "information_description nd ON (n.information_id = nd.information_id) 
        LEFT JOIN " . DB_PREFIX . "information_to_store n2s ON (n.information_id = n2s.information_id) 
        WHERE nd.language_id = '" . (int)$this->config->get('config_language_id') . "' 
        AND n2s.store_id = '" . (int)$this->config->get('config_store_id') . "' 
        AND n.status = '1'
        AND n.category_id = '".(int)$data['category_id']."'
        
         ORDER BY n.sort_order ASC";

		if (isset($data['start']) || isset($data['limit'])) {
		if ($data['start'] < 0) {
		$data['start'] = 0;
		}		
		if ($data['limit'] < 1) {
		$data['limit'] = 10;
		}	

		$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}	

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getTotalNews($category_id) {
     	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "information n 
         LEFT JOIN " . DB_PREFIX . "information_to_store n2s ON (n.information_id = n2s.information_id) 
         WHERE n2s.store_id = '" . (int)$this->config->get('config_store_id') . "' 
         AND n.status = '1'
         AND n.category_id = '".(int)$category_id."'
         ");
	
		if ($query->row) {
			return $query->row['total'];
		} else {
			return FALSE;
		}
	}	
}
?>
