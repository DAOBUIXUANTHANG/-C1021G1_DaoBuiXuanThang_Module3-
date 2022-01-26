package model;

public class Customer {
    String name;
    String birthday;
    String address;
    String urlPicture;

    public Customer() {
    }

    public Customer(String name, String birthday, String address, String urlPicture) {
        this.name = name;
        this.birthday = birthday;
        this.address = address;
        this.urlPicture = urlPicture;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getUrlPicture() {
        return urlPicture;
    }

    public void setUrlPicture(String urlPicture) {
        this.urlPicture = urlPicture;
    }
}
