<?php
class ControllerShippingtransport extends Controller {
    private $error = array();

    public function index() {
        $this->language->load('shipping/transport');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('transport', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->data['heading_title'] = $this->language->get('heading_title');
        $this->data['entry_title'] = $this->language->get('entry_title');
        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_all_zones'] = $this->language->get('text_all_zones');
        $this->data['text_none'] = $this->language->get('text_none');

        $this->data['entry_cost'] = $this->language->get('entry_cost');
        $this->data['entry_tax_class'] = $this->language->get('entry_tax_class');
        $this->data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }
        $this->load->model('localisation/language');

        $languages = $this->model_localisation_language->getLanguages();

        foreach ($languages as $language) {
            if (isset($this->error['title_' . $language['language_id']])) {
                $this->data['error_title_' . $language['language_id']] = $this->error['title_' . $language['language_id']];
            } else {
                $this->data['error_title_' . $language['language_id']] = '';
            }
        }
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_shipping'),
            'href'      => $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('shipping/transport', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['action'] = $this->url->link('shipping/transport', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['cancel'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');
        $this->load->model('localisation/language');

        foreach ($languages as $language) {
            if (isset($this->request->post['transport_title_' . $language['language_id']])) {
                $this->data['transport_title_' . $language['language_id']] = $this->request->post['transport_title_' . $language['language_id']];
            } else {
                $this->data['transport_title_' . $language['language_id']] = $this->config->get('transport_title_' . $language['language_id']);
            }
        }

        $this->data['languages'] = $languages;

        if (isset($this->request->post['transport_cost'])) {
            $this->data['transport_cost'] = $this->request->post['transport_cost'];
        } else {
            $this->data['transport_cost'] = $this->config->get('transport_cost');
        }

        if (isset($this->request->post['transport_tax_class_id'])) {
            $this->data['transport_tax_class_id'] = $this->request->post['transport_tax_class_id'];
        } else {
            $this->data['transport_tax_class_id'] = $this->config->get('transport_tax_class_id');
        }

        $this->load->model('localisation/tax_class');

        $this->data['tax_classes'] = $this->model_localisation_tax_class->getTaxClasses();

        if (isset($this->request->post['transport_geo_zone_id'])) {
            $this->data['transport_geo_zone_id'] = $this->request->post['transport_geo_zone_id'];
        } else {
            $this->data['transport_geo_zone_id'] = $this->config->get('transport_geo_zone_id');
        }

        $this->load->model('localisation/geo_zone');

        $this->data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

        if (isset($this->request->post['transport_status'])) {
            $this->data['transport_status'] = $this->request->post['transport_status'];
        } else {
            $this->data['transport_status'] = $this->config->get('transport_status');
        }

        if (isset($this->request->post['transport_sort_order'])) {
            $this->data['transport_sort_order'] = $this->request->post['transport_sort_order'];
        } else {
            $this->data['transport_sort_order'] = $this->config->get('transport_sort_order');
        }

        $this->template = 'shipping/transport.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'shipping/transport')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        $this->load->model('localisation/language');
        $languages = $this->model_localisation_language->getLanguages();

        foreach ($languages as $language) {
            if (!$this->request->post['transport_title_' . $language['language_id']]) {
                $this->error['title_' .  $language['language_id']] = $this->language->get('error_title');
            }
        }
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
}
?>