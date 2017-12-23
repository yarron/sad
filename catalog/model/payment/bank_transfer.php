<?php 
class ModelPaymentBankTransfer extends Model {
  	public function getMethod($address, $total) {
		$this->language->load('payment/bank_transfer');
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$this->config->get('bank_transfer_geo_zone_id') . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");
		
		if ($this->config->get('bank_transfer_total') > 0 && $this->config->get('bank_transfer_total') > $total) {
			$status = false;
		} elseif (!$this->config->get('bank_transfer_geo_zone_id')) {
			$status = true;
		} elseif ($query->num_rows) {
			$status = true;
		} else {
			$status = false;
		}	
		
		$method_data = array();
	
		if ($status) {  
      		$method_data = array( 
        		'code'       => 'bank_transfer',
        		'title'      => $this->config->get('bank_transfer_title_payment_'.(int)$this->config->get('config_language_id')),//$this->language->get('text_title'),
				'sort_order' => $this->config->get('bank_transfer_sort_order')
      		);
    	}
   
    	return $method_data;
  	}

    public function getDownload($download_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "download d LEFT JOIN " . DB_PREFIX . "download_description dd ON (d.download_id = dd.download_id) WHERE d.download_id = '" . (int)$download_id . "' AND dd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

        return $query->row;
    }
}
?>