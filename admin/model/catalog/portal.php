<?php
class ModelCatalogPortal extends Model {
	public function addCategory($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "portal SET parent_id = '" . (int)$data['parent_id'] . "',  sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', date_modified = NOW(), date_added = NOW()");

		$portal_id = $this->db->getLastId();
				
		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "portal SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE portal_id = '" . (int)$portal_id . "'");
		}
		
		foreach ($data['category_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "portal_description SET portal_id = '" . (int)$portal_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "', seo_title = '" . $this->db->escape($value['seo_title']) . "', seo_h1 = '" . $this->db->escape($value['seo_h1']) . "'");
		}

		// MySQL Hierarchical Data Closure Table Pattern
		$level = 0;
		
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "portal_path` WHERE portal_id = '" . (int)$data['parent_id'] . "' ORDER BY `level` ASC");
		
		foreach ($query->rows as $result) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "portal_path` SET `portal_id` = '" . (int)$portal_id . "', `path_id` = '" . (int)$result['path_id'] . "', `level` = '" . (int)$level . "'");
			
			$level++;
		}
		
		$this->db->query("INSERT INTO `" . DB_PREFIX . "portal_path` SET `portal_id` = '" . (int)$portal_id . "', `path_id` = '" . (int)$portal_id . "', `level` = '" . (int)$level . "'");

		
				
		if (isset($data['category_store'])) {
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "portal_to_store SET portal_id = '" . (int)$portal_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
		
		// Set which layout to use with this category
		if (isset($data['category_layout'])) {
			foreach ($data['category_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "portal_to_layout SET portal_id = '" . (int)$portal_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
						
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'portal_id=" . (int)$portal_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
		
		$this->cache->delete('portal');
	}
	
	public function editCategory($portal_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "portal SET parent_id = '" . (int)$data['parent_id'] . "',  sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', date_modified = NOW() WHERE portal_id = '" . (int)$portal_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "portal SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE portal_id = '" . (int)$portal_id . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "portal_description WHERE portal_id = '" . (int)$portal_id . "'");

		foreach ($data['category_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "portal_description SET portal_id = '" . (int)$portal_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "', seo_title = '" . $this->db->escape($value['seo_title']) . "', seo_h1 = '" . $this->db->escape($value['seo_h1']) . "'");
		}
		
		// MySQL Hierarchical Data Closure Table Pattern
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "portal_path` WHERE path_id = '" . (int)$portal_id . "' ORDER BY level ASC");
		
		if ($query->rows) {
			foreach ($query->rows as $category_path) {
				// Delete the path below the current one
				$this->db->query("DELETE FROM `" . DB_PREFIX . "portal_path` WHERE portal_id = '" . (int)$category_path['portal_id'] . "' AND level < '" . (int)$category_path['level'] . "'");
				
				$path = array();
				
				// Get the nodes new parents
				$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "portal_path` WHERE portal_id = '" . (int)$data['parent_id'] . "' ORDER BY level ASC");
				
				foreach ($query->rows as $result) {
					$path[] = $result['path_id'];
				}
				
				// Get whats left of the nodes current path
				$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "portal_path` WHERE portal_id = '" . (int)$category_path['portal_id'] . "' ORDER BY level ASC");
				
				foreach ($query->rows as $result) {
					$path[] = $result['path_id'];
				}
				
				// Combine the paths with a new level
				$level = 0;
				
				foreach ($path as $path_id) {
					$this->db->query("REPLACE INTO `" . DB_PREFIX . "portal_path` SET portal_id = '" . (int)$category_path['portal_id'] . "', `path_id` = '" . (int)$path_id . "', level = '" . (int)$level . "'");
					
					$level++;
				}
			}
		} else {
			// Delete the path below the current one
			$this->db->query("DELETE FROM `" . DB_PREFIX . "portal_path` WHERE portal_id = '" . (int)$portal_id . "'");
			
			// Fix for records with no paths
			$level = 0;
			
			$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "portal_path` WHERE portal_id = '" . (int)$data['parent_id'] . "' ORDER BY level ASC");
			
			foreach ($query->rows as $result) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "portal_path` SET portal_id = '" . (int)$portal_id . "', `path_id` = '" . (int)$result['path_id'] . "', level = '" . (int)$level . "'");
				
				$level++;
			}
			
			$this->db->query("REPLACE INTO `" . DB_PREFIX . "portal_path` SET portal_id = '" . (int)$portal_id . "', `path_id` = '" . (int)$portal_id . "', level = '" . (int)$level . "'");
		}
		
				
		$this->db->query("DELETE FROM " . DB_PREFIX . "portal_to_store WHERE portal_id = '" . (int)$portal_id . "'");
		
		if (isset($data['category_store'])) {		
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "portal_to_store SET portal_id = '" . (int)$portal_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "portal_to_layout WHERE portal_id = '" . (int)$portal_id . "'");

		if (isset($data['category_layout'])) {
			foreach ($data['category_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "portal_to_layout SET portal_id = '" . (int)$portal_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
						
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'portal_id=" . (int)$portal_id. "'");
		
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'portal_id=" . (int)$portal_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
		
		$this->cache->delete('portal');
	}
	
	public function deleteCategory($portal_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "portal_path WHERE portal_id = '" . (int)$portal_id . "'");
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_path WHERE path_id = '" . (int)$portal_id . "'");
			
		foreach ($query->rows as $result) {	
			$this->deleteCategory($result['portal_id']);
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "portal WHERE portal_id = '" . (int)$portal_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "portal_description WHERE portal_id = '" . (int)$portal_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "portal_to_store WHERE portal_id = '" . (int)$portal_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "portal_to_layout WHERE portal_id = '" . (int)$portal_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'portal_id=" . (int)$portal_id . "'");
		
		$this->cache->delete('portal');
	} 
	
	
			
	public function getCategory($portal_id) {
		$query = $this->db->query("SELECT DISTINCT *, 
            (SELECT GROUP_CONCAT(cd1.name ORDER BY level SEPARATOR ' &gt; ') 
                FROM " . DB_PREFIX . "portal_path cp 
                LEFT JOIN " . DB_PREFIX . "portal_description cd1 
                    ON (cp.path_id = cd1.portal_id 
                    AND cp.portal_id != cp.path_id) 
                WHERE cp.portal_id = c.portal_id 
                    AND cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' 
                GROUP BY cp.portal_id) AS path, 
            (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'portal_id=" . (int)$portal_id . "') AS keyword 
                FROM " . DB_PREFIX . "portal c 
                LEFT JOIN " . DB_PREFIX . "portal_description cd2 
                    ON (c.portal_id = cd2.portal_id) 
                WHERE c.portal_id = '" . (int)$portal_id . "' 
                    AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "'");
		
		return $query->row;
	} 
	
	public function getCategories($data) {
		$sql = "SELECT cp.portal_id AS portal_id, 
        GROUP_CONCAT(cd1.name ORDER BY cp.level SEPARATOR ' &gt; ') AS name, 
        c.parent_id, c.sort_order 
        FROM " . DB_PREFIX . "portal_path cp 
            LEFT JOIN " . DB_PREFIX . "portal c 
                ON (cp.portal_id = c.portal_id) 
            LEFT JOIN " . DB_PREFIX . "portal_description cd1 
                ON (cp.path_id = cd1.portal_id) 
            LEFT JOIN " . DB_PREFIX . "portal_description cd2 
                ON (cp.portal_id = cd2.portal_id) 
        WHERE cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' 
            AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c.portal_id !='".(int)$data."'";
		
		

		$sql .= " GROUP BY cp.portal_id ORDER BY name";
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}				

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	
		 
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}
						
		$query = $this->db->query($sql);
		
		return $query->rows;
	}
				
	public function getCategoryDescriptions($portal_id) {
		$category_description_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "portal_description WHERE portal_id = '" . (int)$portal_id . "'");
		
		foreach ($query->rows as $result) {
			$category_description_data[$result['language_id']] = array(
				'seo_title'        => $result['seo_title'],
				'seo_h1'           => $result['seo_h1'],
				'name'             => $result['name'],
				'meta_keyword'     => $result['meta_keyword'],
				'meta_description' => $result['meta_description'],
				'description'      => $result['description']
			);
		}
		
		return $category_description_data;
	}	
	
	

	
	public function getCategoryStores($portal_id) {
		$category_store_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "portal_to_store WHERE portal_id = '" . (int)$portal_id . "'");

		foreach ($query->rows as $result) {
			$category_store_data[] = $result['store_id'];
		}
		
		return $category_store_data;
	}

	public function getCategoryLayouts($portal_id) {
		$category_layout_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "portal_to_layout WHERE portal_id = '" . (int)$portal_id . "'");
		
		foreach ($query->rows as $result) {
			$category_layout_data[$result['store_id']] = $result['layout_id'];
		}
		
		return $category_layout_data;
	}
		
	public function getTotalCategories() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "portal");
		
		return $query->row['total'];
	}
		
	public function getTotalCategoriesByImageId($image_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category WHERE image_id = '" . (int)$image_id . "'");
		
		return $query->row['total'];
	}

	
    public function getCategoriesByParentId($parent_id = 0) {
		$query = $this->db->query("SELECT *, 
            (SELECT COUNT(parent_id) FROM " . DB_PREFIX . "portal 
            WHERE parent_id = c.portal_id) AS children 
        FROM " . DB_PREFIX . "portal c 
        LEFT JOIN " . DB_PREFIX . "portal_description cd ON (c.portal_id = cd.portal_id) 
        WHERE c.parent_id = '" . (int)$parent_id . "' 
        AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' 
        ORDER BY c.sort_order, cd.name");
		
		return $query->rows;
	}	
    
    public function getAllCategories() {
		$category_data = $this->cache->get('portal.all.' . $this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id'));

		if (!$category_data || !is_array($category_data)) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "portal c 
            LEFT JOIN " . DB_PREFIX . "portal_description cd ON (c.portal_id = cd.portal_id) 
            LEFT JOIN " . DB_PREFIX . "portal_to_store c2s ON (c.portal_id = c2s.portal_id) 
            WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "' 
            AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  
            ORDER BY c.parent_id, c.sort_order, cd.name");

			$category_data = array();
			foreach ($query->rows as $row) {
				$category_data[$row['parent_id']][$row['portal_id']] = $row;
			}

			$this->cache->set('portal.all.' . $this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id'), $category_data);
		}

		return $category_data;
	}
    
    public function getInformationCategories($information_id) {
		$information_category_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_portal WHERE information_id = '" . (int)$information_id . "'");
		
		foreach ($query->rows as $result) {
			$information_category_data[] = $result['portal_id'];
		}

		return $information_category_data;
	}

	public function getInformationMainCategoryId($information_id) {
		$query = $this->db->query("SELECT portal_id FROM " . DB_PREFIX . "information_to_portal WHERE information_id = '" . (int)$information_id . " AND main_category = '1' LIMIT 1");

		return ($query->num_rows ? (int)$query->row['portal_id'] : 0);
	}	
}
?>