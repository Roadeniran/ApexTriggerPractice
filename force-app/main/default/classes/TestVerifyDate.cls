@isTest
public class TestVerifyDate {
    
    @isTest
    static void testCheckDatesWithin30Days() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(10); // within 30 days

        Date result = VerifyDate.CheckDates(date1, date2);

        System.assertEquals(date2, result, 'Should return date2 since it is within 30 days');
    }

    @isTest
    static void testCheckDatesBeyond30Days() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(35); // beyond 30 days

        Date expected = Date.newInstance(date1.year(), date1.month(), Date.daysInMonth(date1.year(), date1.month()));
        Date result = VerifyDate.CheckDates(date1, date2);

        System.assertEquals(expected, result, 'Should return end of the month since date2 is beyond 30 days');
    }
}
