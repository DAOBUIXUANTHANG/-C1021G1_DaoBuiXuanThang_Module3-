public class Calculator {
    public Calculator() {
    }

    public static double calculated(double fistOpera , double secondOpera , char Operator){
        switch (Operator){
            case '+' :
                return fistOpera + secondOpera;
            case '-' :
                return fistOpera - secondOpera;
            case '/':
                if (secondOpera != 0){
                    return fistOpera / secondOpera;
                } else {
                    throw new RuntimeException("khong the chia cho 0");
                }
            case '*':
                return fistOpera * secondOpera;
            default:
                throw new RuntimeException("loi khong xac dinh");

        }

    }
}
