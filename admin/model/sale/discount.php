<?php
class ModelSaleDiscount extends Model {
	public function createModuleTables() {
		$query = $this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "discount (
                    discount_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, 
                    name VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, 
                    price DECIMAL( 15, 2 ) NOT NULL,
                    percent DECIMAL( 15, 2 ) NOT NULL,
                    sort_order INT( 11 ) NOT NULL,
                    status TINYINT( 1 ) NOT NULL 
                    ) ENGINE = MYISAM CHARACTER SET utf8 COLLATE utf8_general_ci");
		$query = $this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "discount_description (
                    discount_id INT( 11 ) NOT NULL DEFAULT  '0', 
                    language_id INT NOT NULL DEFAULT  '0',
                    description TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
                    )ENGINE = MYISAM CHARACTER SET utf8 COLLATE utf8_general_ci");
	}
    
    public function addDiscount($data) {
      	$this->db->query("INSERT INTO " . DB_PREFIX . "discount 
          SET price = '" .(float)$data['price'] . "', 
          name = '" . $this->db->escape($data['name']) . "', 
          sort_order = '" . (int)$data['sort_order'] . "', 
          percent = '" . (float)$data['percent'] . "', 
          status = '" . (int)$data['status']. "'");
		
		$discount_id = $this->db->getLastId();

		foreach ($data['discount_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "discount_description SET discount_id = '" . (int)$discount_id . "', language_id = '" . (int)$language_id  . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		$this->cache->delete('discount');
	}
	
    public function editDiscount($discount_id, $data) {
      	$this->db->query("UPDATE " . DB_PREFIX . "discount 
                        SET name = '" . $this->db->escape($data['name']) . "', 
                        sort_order = '" . (int)$data['sort_order']  . "', 
                        price = '" . (float)$data['price'].  "', 
                        percent = '" . (float)$data['percent']. "', 
                        status = '" . (int)$data['status']."' 
                        WHERE discount_id = '" . (int)$discount_id . "'");


		$this->db->query("DELETE FROM " . DB_PREFIX . "discount_description WHERE discount_id = '" . (int)$discount_id . "'");

		foreach ($data['discount_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "discount_description 
                                SET discount_id = '" . (int)$discount_id . "', 
                                language_id = '" . (int)$language_id . "',   
                                description = '" . $this->db->escape($value['description']) . "'");
		}

		$this->cache->delete('discount');
	}
    
    public function getDiscounts($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "discount";
			
			$sort_data = array(
				'percent',
				'sort_order'
			);	
			
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY percent";	
			}
			
			if (isset($data['order']) && ($data['order'] == 'DESC')) {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}
			
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
		} else {
			$discounts_data = $this->cache->get('discount');
		
			if (!$discounts_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "discount    
                                           ORDER BY sort_order");
	
				$discounts_data = $query->rows;
			
				//$this->cache->set('discount', $discounts_data);
			}
		 
			return $discounts_data;
		}
	}
    
    public function getDiscount($discount_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "discount 
                                           WHERE discount_id = " . $discount_id . "     
                                           ");
		return $query->row;
	}
    
    public function getDiscountDescriptions($discount_id) {
		$discount_description_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "discount_description WHERE discount_id = '" . (int)$discount_id . "'");
		
		foreach ($query->rows as $result) {
			$discount_description_data[$result['language_id']] = array(
				'description'      => $result['description'],
			);
		}
		
		return $discount_description_data;
	}
    
   	public function deleteDiscount($discount_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "discount WHERE discount_id = '" . (int)$discount_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "discount_description WHERE discount_id = '" . (int)$discount_id . "'");
			
		$this->cache->delete('discount');
	}	
}
?>