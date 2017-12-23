<?php  
class ControllerModuleFeedback extends Controller {
	protected function index($setting) {
		$this->language->load('module/feedback');
		
        $this->data['heading_title'] = $this->language->get('heading_title');
        $this->data['text_message'] = $this->language->get('text_message');

    	$this->data['entry_name'] = $this->language->get('entry_name');
    	$this->data['entry_email'] = $this->language->get('entry_email');
    	$this->data['entry_enquiry'] = $this->language->get('entry_enquiry');
		
        $this->data['button_post'] = $this->language->get('button_post');
        				
		$this->data['error_name'] = $this->language->get('error_name');
		$this->data['error_email'] = $this->language->get('error_email');
		$this->data['error_enquiry'] = $this->language->get('error_enquiry');
	
        $this->data['action'] = $this->url->link('module/feedback/success');
        
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/feedback.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/feedback.tpl';
		} else {
			$this->template = 'default/template/module/feedback.tpl';
		}
		
		$this->render();
  	}
    
    public function success(){
        $this->language->load('module/feedback');
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->hostname = $this->config->get('config_smtp_host');
			$mail->username = $this->config->get('config_smtp_username');
			$mail->password = $this->config->get('config_smtp_password');
			$mail->port = $this->config->get('config_smtp_port');
			$mail->timeout = $this->config->get('config_smtp_timeout');				
			$mail->setTo($this->config->get('config_email'));
	  		$mail->setFrom($this->request->post['email']);
	  		$mail->setSender($this->request->post['name']);
	  		$mail->setSubject(html_entity_decode(sprintf($this->language->get('email_subject'), $this->request->post['name']), ENT_QUOTES, 'UTF-8'));
	  		$mail->setText(strip_tags(html_entity_decode($this->request->post['enquiry'], ENT_QUOTES, 'UTF-8')));
      		$mail->send();

	  		die("post");
    	}
    }
    
    private function validate() {
    	if ((mb_strlen($this->request->post['name'], 'UTF-8') < 3) || (mb_strlen($this->request->post['name'], 'UTF-8') > 32)) {
      		$this->error['name'] = $this->language->get('error_name');
    	}

    	if (!preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
      		$this->error['email'] = $this->language->get('error_email');
    	}

    	if ((mb_strlen($this->request->post['enquiry'], 'UTF-8') < 10) || (mb_strlen($this->request->post['enquiry'], 'UTF-8') > 3000)) {
      		$this->error['enquiry'] = $this->language->get('error_enquiry');
    	}


		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}  	  
  	}
}


?>