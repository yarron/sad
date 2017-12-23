<?php
class ModelDesignBanner extends Model {	
	public function getBanner($banner_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "banner_image bi 
        LEFT JOIN " . DB_PREFIX . "banner_image_description bid ON (bi.banner_image_id  = bid.banner_image_id) 
        WHERE bi.banner_id = '" . (int)$banner_id . "' 
        AND bid.language_id = '" . (int)$this->config->get('config_language_id') . "'
        ORDER BY bi.sort_order ASC
        ");
		
		return $query->rows;
	}
    
    public function getGalleryAll($data) {
    	$sql = "SELECT DISTINCT * FROM " . DB_PREFIX . "banner b
    	WHERE b.status = '1'
    	AND b.gallery = '1'
    	ORDER BY
    	b.sort_order DESC";
    
    	if (isset($data['start']) || isset($data['limit'])) {
        	if ($data['start'] < 0) $data['start'] = 0;
        			
        	if ($data['limit'] < 1) $data['limit'] = 10;

        	$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
    	}	
    
    	$query = $this->db->query($sql);
    
    	return $query->rows;
	}

    public function getGalleryImage($id) {
        $sql = "SELECT image FROM " . DB_PREFIX . "banner_image
    	WHERE banner_id = ".(int)$id."
    	ORDER BY sort_order ASC LIMIT 3";

        $query = $this->db->query($sql);

        return $query->rows;
    }
    
    public function getTotalGallery() {
     	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "banner
            
            WHERE status = '1' AND gallery = '1'");
	
		if ($query->row) {
			return $query->row['total'];
		} else {
			return FALSE;
		}
	}
    
   	public function getGallery($banner_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "banner WHERE banner_id = '" . (int)$banner_id . "' AND status = '1' AND gallery = '1' ");
		
		return $query->row;
	}
}
?>