package org.example;

public class Main {
    public static String tenantID = "put_here_your_tenant_ID";
    public static String clientID = "put_here_your_client_ID";
    public static String client_secret = "put_here_your_SECRET";
    public static String mail_address = "your_mail@you_domain";

    public static void main(String[] args) {
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>> Started");

        GetToken getToken = new GetToken();
        try {
            String token = getToken.getAnAccessToken(tenantID, clientID, client_secret);
            System.out.println(">>>>>>>>>>>>>>>>>>>>>>> Token="+token);
            try {
                ConnetMail connetMail = new ConnetMail();
                connetMail.open(token,mail_address);
            } catch (Exception e) {
                System.out.println("ERROR="+e.getMessage());
            }
        } catch (Exception e) {
            System.out.println(">>>>>>>>>>>>>>>>>>>>>>> ERROR="+e.getMessage());
        }

        System.out.println(">>>>>>>>>>>>>>>>>>>>>>> Ended");
    }
}