public class AnimalLocator {
    public static String getAnimalNameById(Integer id) {
        // This method retrieves the name of an animal by its ID from an external API.
        // It returns the name as a String or null if the animal is not found.
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            return (String) result.get('name');
        } else {
            return null;
        }
    }
}
