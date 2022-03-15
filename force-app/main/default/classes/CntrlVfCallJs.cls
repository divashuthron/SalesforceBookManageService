public with sharing class CntrlVfCallJs {
    public String myVariable { get; set; }
    
    public CntrlVfCallJs() {
        myVariable = 'Hello World';
    }

    public void myMethod() {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Apex method called'));
    }
}