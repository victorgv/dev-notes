package org.example;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.hc.client5.http.ClientProtocolException;
import org.apache.hc.client5.http.classic.methods.HttpPost;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.core5.http.ContentType;
import org.apache.hc.core5.http.io.entity.StringEntity;
import org.apache.hc.core5.http.message.BasicHeader;


import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

public class GetToken {
    public String getAnAccessToken(String tenantId, String clientId, String client_secret) throws ClientProtocolException, IOException {
        CloseableHttpClient client = HttpClients.createDefault();
        String URI = "https://login.microsoftonline.com/" + tenantId + "/oauth2/v2.0/token";
        String scopes = "https://outlook.office365.com/.default";
        String encodedBody = "client_id=" + clientId + "&scope=" + scopes + "&client_secret=" + client_secret + "&grant_type=client_credentials";
        
        HttpPost httpPost = new HttpPost(URI);
        httpPost.setEntity(new StringEntity(encodedBody, ContentType.APPLICATION_FORM_URLENCODED));
        httpPost.addHeader(new BasicHeader("cache-control", "no-cache"));
        CloseableHttpResponse closeableHttpResponse = client.execute(httpPost);
        InputStream inputStream = closeableHttpResponse.getEntity().getContent();
        byte[] response = inputStream.readAllBytes();
        ObjectMapper objectMapper = new ObjectMapper();
        JavaType type = objectMapper.constructType(objectMapper.getTypeFactory().constructParametricType(Map.class, String.class, String.class));
        Map<String, String> parsed = new ObjectMapper().readValue(response, type);

        return parsed.get("access_token");
    }
}
