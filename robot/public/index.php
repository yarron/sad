<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

//wget -O - -q -t 1 http://sadovnote.ru/robot/public/

require '../vendor/autoload.php';
require '../../config.php';
require 'Core.php';
require 'Email.php';

$config['displayErrorDetails'] = true;
$config['addContentLengthHeader'] = false;

$app = new \Slim\App(["settings" => $config]);

$app->get('/', function (Request $request, Response $response) use ($config){
    $data = new \Email();

    $emails = $data->getEmails();

    $config = $data->getConfig();

    // Create the Transport
    //$transport = Swift_MailTransport::newInstance();
    $transport = Swift_SmtpTransport::newInstance($config['config_smtp_host'], $config['config_smtp_port'])
        ->setUsername($config['config_smtp_username'])
        ->setPassword($config['config_smtp_password']);

    // Create Mailer with our Transport.
    $mailer = Swift_Mailer::newInstance($transport);

    $log_emails = [
        'success'=>0,
        'error' =>0
    ];

    foreach($emails as $key=>$email){
        // Setting all needed info and passing in my email template.
        $message = Swift_Message::newInstance($email['theme'])
            ->setFrom([$config['config_email'] => $config['config_name']])
            ->setTo([$email['email'] => $email['full_name']])
            ->setBody($email['message'])
            ->setContentType("text/html");

        // Send the message
        $send = $mailer->send($message);
        $emails[$key]['status'] = $send;
        if($send === 1){
            $log_emails['success']++;
        } else{
            $log_emails['error']++;
        }
    }


    if(count($emails)){
        $admin_theme = "Отчет почтовой рассылки";

        $admin_message = "<h3>Детали</h3>";
        $admin_message .= "<p>Всего отправляемых писем: <b>".count($emails)."</b></p>";
        $admin_message .= "<p>Количество успешно отправленных писем: <b>".$log_emails['success']."</b></p>";
        $admin_message .= "<p>Количество неудачно отправленных писем: <b>".$log_emails['error']."</b></p>";
        $admin_message .= "<ul>";

        foreach($emails as $key=>$value){
            if($value['status'] !== 1){
                $admin_message .= "<li>".$value['email']." "."<span style='color: red' title='".$value['status']."'>Ошибка отправки</span></li>";
            }
        }
        $admin_message .= "</ul>";
        $admin_message .= "<h3>Подробности письма</h3>";
        $admin_message .= "<b>Тема:</b> ".$emails[0]['theme']."<br/><br/>";
        $admin_message .= "<b>Сообщение:</b> ".$emails[0]['message'];

        // Setting all needed info and passing in my email template.
        $admin_message = Swift_Message::newInstance($admin_theme)
            ->setFrom([$config['config_email'] => 'Robot Mail'])
            ->setTo([
                $config['config_email'] => $config['config_name']
            ])
            ->setBody($admin_message)
            ->setContentType("text/html");

        // Send the message
        $mailer->send($admin_message);

        echo $admin_theme;
        echo $admin_message;

        $remove = $data->removeEmails($emails);
    }

    return $response;
});

$app->run();

