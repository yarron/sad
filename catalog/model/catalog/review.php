<?php
class ModelCatalogReview extends Model {		
	public function addReview($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "review SET 
            author = '" . $this->db->escape($data['name']) . "', 
            text = '" . $this->db->escape($data['enquiry']) . "', 
            date_added = NOW()");
	}
		
	public function getReviews($start = 0, $limit = 20) {
		if ($start < 0) {
			$start = 0;
		}
		
		if ($limit < 1) {
			$limit = 20;
		}		
		
		$query = $this->db->query("SELECT review_id, author, text, date_added 
            FROM " . DB_PREFIX . "review  
            WHERE status = '1' 
            ORDER BY date_added DESC LIMIT " . (int)$start . "," . (int)$limit);
			
		return $query->rows;
	}
	
	public function getAverageRating($product_id) {
		$query = $this->db->query("SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review WHERE status = '1' AND product_id = '" . (int)$product_id . "' GROUP BY product_id");
		
		if (isset($query->row['total'])) {
			return (int)$query->row['total'];
		} else {
			return 0;
		}
	}	
	
	public function getTotalReviews() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review 
        WHERE status = '1'");
		
		return $query->row['total'];
	}

	public function getTotalReviewsByProductId($product_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND p.date_available <= NOW() AND p.status = '1' AND r.status = '1' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
		
		return $query->row['total'];
	}
}
?>