import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopers = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "buybox-app",
        "private_key_id": "1e62a15d960651811638b94f7a447f102549a91b",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDFibZn5al8xRpH\nKfw4CixHdgR32iHzj/3A57VQTI3JulgaDNSWtSAb4qd+5e3G+ktULL9LhnMsBebN\neZo/zQgi8LzIj3m4wLYv8YhQFG07aHXn5vRRNUbtt1M4qzHKKUvgzyG6kmNwRXbb\nUN51PsKPhDeLjSnHl38vl122H3Q354gYVeMdOYtGYRhXySJSI130ywbTrRPWQj3M\nDg6mOtwr1rFttuiffjuE2F3IYKe4eG4Rs91ndoQltwFNYYqJy9WBmE/rixem7m6E\ntTBj8ogOsJ4R3SQXKUV/E1sqrzmGgRdd8olisS3Dtht7JWh030DqpFjzlI6fheZT\n2I9pqiHlAgMBAAECggEAMiwDmcjxruCLB5co2fzveSkHAn/zTp78ZvITEbWX76w2\nM0ud9TdE1ABR5X+10GuDFXqWDbM07nIDSJ4BqQHE9sbpVBFo6516yJuSsTA2/DdQ\ndxmoZTXgcYE2EHce2sd5X7yMRwxmWD40bYjRL7tEhFojF30/ptOaOLa71QWRKZ9g\n9/EF50TKiilyE+EdHf8sJZhX4SXLv5qjX/fzFFDYdoCfc7Dr4DxSk7kllWPsb/9h\n5mc8EP915pjnt26TrIEKNf0rurRTSQ2vL0g1euBoocn833tgI+M3GflN+nWXyDbe\nwkal93nTzTrI1UUUjjG2uDkVxPRB49UukTYCUy6jwwKBgQDuxlmlehB/fklk6n+R\nDs+1hmP12VjMFnyda8aaCysfAAuJdXqMXcudZCJcxosMCCaAqHwcRKeZdM9WWmxj\nAYDZbZmmSEhWYsAAh6lg5vsN3Ar1a9E8ubunTfexOptV8ALeDRSVGziKe/JyyL+f\naV7jdf1iXyfH0Mz/8UWPFIl/SwKBgQDTyc6wYSns9D1ghrbohF68lvdde8Sy1KTM\nlzHG/WJMt+BxLdnMs6BRpQhy6kPhziTKP76r/kQeOCHptS5lOeR4Fywm5fQI88Mj\na9t39kBcXb8UIvpyNRMULEm746xJ7R2t5e8+qQ665wSdC8jmwvuYSoHx3Yf2Whkh\nlxgaWBS1jwKBgCWypTauBerLGnVXXJqfVwXW2PNYxF88caI9ANcTSlSToj6qkJWW\nvW31AEPbiNp2cvW/JBEmebuNqKp+jjw3YYtydV6+bMVOw/eRc5l7/kka45QJ2LgY\nrtrkQWX21c2Enj9Gm2hLKusaVJXwweg+L6AD4eRlF5fBjIwgIJZNbMPvAoGAA9Up\nGmQHwDQDUFXfxYFvvXX18AknXB0hBlrOGc3IE59YPnQX9u5hPlkAOCQpKlLys35H\n0xD85pcZdgNDXa2YhtvUfre2nNrccy2mgRtBuuovZQvlAGAZgkny46WRHp1d5iG9\nHKMukw9PNBBciGCK8QyYIWpi5YBn6AW19/QUG90CgYAxx2M9uBGs0S2A5SmVy6qF\n/Nma110Sv+9LPFMAY7u5kY5WCHjXqUaVNOirLTAurTquCINtU/36zMJp3tZwCQSL\nA3eKAcqYQduXntg1WVwEUOKIWd0zPJi1+nmiYixGWa9oANJbq1Gg9q/pJbilDS62\nAaOJLBAuBHFF9YI8GjlMYw==\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-fbsvc@buybox-app.iam.gserviceaccount.com",
        "client_id": "109463930862707683545",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40buybox-app.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com",
      }),
      scopers,
    );
    final accessServerKey = client.credentials.accessToken.data;

    return accessServerKey;
  }
}
