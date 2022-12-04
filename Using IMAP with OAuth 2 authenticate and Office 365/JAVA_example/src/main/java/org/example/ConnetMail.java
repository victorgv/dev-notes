package org.example;


import jakarta.mail.*;

import java.util.Properties;

public class ConnetMail {
    public void open(String token, String mailAddress) throws MessagingException {
        Properties props = new Properties();

        props.put("mail.store.protocol", "imap");
        props.put("mail.imap.ssl.enable", "true");
        props.put("mail.imap.starttls.enable", "true");
        props.put("mail.imap.auth", "true");
        props.put("mail.imap.auth.mechanisms", "XOAUTH2");
        props.put("mail.imap.user", mailAddress);
        props.put("mail.debug", "true");
        props.put("mail.debug.auth", "true");

        Session session = Session.getInstance(props);
        session.setDebug(true);
        Store store = session.getStore("imap");
        System.out.println(">>>>>>>>>>>>>>> Connecting... "+mailAddress);
        store.connect("outlook.office365.com", 993, mailAddress, token);
        System.out.println(">>>>>>>>>>>>>>> Connecting... DONE!!");

        Folder[] f = store.getDefaultFolder().list();
        for(Folder fd:f)
            System.out.println(">> "+fd.getName());

        Folder fldr = store.getFolder("Inbox");
        fldr.open(Folder.HOLDS_MESSAGES);
        int count = fldr.getMessageCount();

        System.out.println(">>>>>>>>>>>>>>> You have: " + count + " in INBOX");
    }
}
