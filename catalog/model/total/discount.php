<?php

class ModelTotalDiscount extends Model
{
    public function getTotal(&$total_data, &$total, &$taxes)
    {
        $this->load->language('total/discount');

        $now_percent = $discount = 0;

        if ($this->config->get('discount_status')) {
            $date_start = 0;
            $date_end = 9999999999;
            $date_now = strtotime(date("Y-m-d"));

            if ($this->config->get('discount_date_start')) {
                $date_start = strtotime($this->config->get('discount_date_start'));
            }

            if ($this->config->get('discount_date_end')) {
                $date_end = strtotime($this->config->get('discount_date_end'));
            }

            if ($date_start <= $date_now && $date_now < $date_end) {
                $query = $this->db->query("
                  SELECT 
                    price,
                    percent 
                  FROM " . DB_PREFIX . "discount 
                  WHERE status='1' ORDER BY sort_order");

                $discounts = $query->rows;
                foreach ($discounts as $disc) {
                    if ($total > $disc['price']) {
                        $now_percent = (float)$disc['percent'];
                    }
                }

                if ($now_percent > 0) {
                    $discount = (float)($total * $now_percent) / 100;
                    $total_data[] = array(
                        'code' => 'discount',
                        'title' => $this->language->get('text_discount') . " (" . $now_percent . "%)",
                        'text' => "-" . $this->currency->format($discount),
                        'value' => $discount,
                        'sort_order' => $this->config->get('discount_sort_order')
                    );

                }
            }

        }

        $total -= $discount;
    }

    public function getDiscounts()
    {
        $discount_data = $this->cache->get('discount');

        if (!$discount_data) {
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "discount d 
                                        LEFT JOIN " . DB_PREFIX . "discount_description dd ON (d.discount_id = dd.discount_id) 
                                        WHERE dd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND d.status='1' ORDER BY d.sort_order");

            $discount_data = $query->rows;
            $this->cache->set('discount', $discount_data);
        }

        return $discount_data;
    }
}

?>