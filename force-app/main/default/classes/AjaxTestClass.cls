global with sharing class AjaxTestClass {
    private String currTime;

    public void setCurrTime() {
        currTime = System.now().format('EEEE, MMMM d, yyyy - hh:mm:ss');
    }

    public String getCurrTime() {
        return currTime;
    }
}