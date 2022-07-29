import java.util.Arrays;
import java.util.Comparator;
import java.util.Scanner;
import javax.swing.text.html.MinimalHTMLWriter;

class Process {

    String name;
    int BT, WT, AT, CT, TAT, remBT, priority;
    boolean flag;

    public Process(String name, int burst, int AT) {
        this.name = name;
        BT = burst;
        this.AT = AT;
        WT = CT = TAT = 0;
        remBT = BT;
        priority = 0;
    }

    public Process(String name, int burst, int AT, int PR) {
        this.name = name;
        BT = burst;
        this.AT = AT;
        WT = CT = TAT = 0;
        remBT = BT;
        priority = PR;
        flag = false;
    }

    public void display() {
        System.out.println(name + "\t" + BT + "\t" + AT + "\t" + CT + "\t" + TAT + "\t" + WT + "\t" + priority);
    }
}

class SortByArrival implements Comparator<Process> {

    @Override
    public int compare(Process p1, Process p2) {
        return p1.AT - p2.AT;
    }
}

class SortByPriority implements Comparator<Process> {

    @Override
    public int compare(Process o1, Process o2) {
        return o1.priority - o2.priority;
    }
}

class FCFS {

    // Criteria: Arrival Time
    // Mode: Non-Preemptive

    // TAT = CT - AT
    // WT = TAT - BT
    // RT = WT

    private Scanner sc;

    public void execute() {
        sc = new Scanner(System.in);

        System.out.println("Enter Number of Processes:");
        int numProcess = sc.nextInt();
        Process[] process = new Process[numProcess];

        for (int i = 0; i < numProcess; i++) {
            System.out.println("P(" + (i + 1) + "):Enter Arrival time & Burst time");
            int at = sc.nextInt();
            int bt = sc.nextInt();

            process[i] = new Process("P" + (i + 1), bt, at);
        }

        Arrays.sort(process, new SortByArrival());

        int sum = 0;
        double avgWT = 0, avgTAT = 0;
        System.out.println("\n\nPRNo\tBT\tAT\tCT\tTAT\tWT");
        System.out.println("============================================================================================");
        for (int i = 0; i < numProcess; i++) {
            sum = process[i].CT = sum + process[i].BT;
            process[i].TAT = process[i].CT - process[i].AT;
            process[i].WT = process[i].TAT - process[i].BT;

            if (process[i].WT < 0) {
                process[i].WT = 0;
            }

            avgWT = avgWT + process[i].WT;
            avgTAT = avgTAT + process[i].TAT;

            process[i].display();
        }
        avgTAT = avgTAT / numProcess;
        avgWT = avgWT / numProcess;
        System.out.println("Average Waiting Time" + avgWT);
        System.out.println("Average TAT=" + avgTAT);
    }
}

class SJF {

    private Scanner sc;

    public void execute() {
        sc = new Scanner(System.in);

        System.out.println("Enter Number of Processes:");
        int numProcess = sc.nextInt();
        Process[] process = new Process[numProcess];

        for (int i = 0; i < numProcess; i++) {
            System.out.println("P(" + (i + 1) + "):Enter Arrival time & Burst time");
            int at = sc.nextInt();
            int bt = sc.nextInt();

            process[i] = new Process("P" + (i + 1), bt, at);
        }

        int min = Integer.MAX_VALUE;
        int count = 0, shortest = 0;
        int time = 0;
        int sum = 0;
        double avgWT = 0, avgTAT = 0;
        boolean check = false;
        System.out.println("\n\nPRNo\tBT\tAT\tCT\tTAT\tWT");
        System.out.println("============================================================================================");
        while (count < numProcess) {
            for (int i = 0; i < numProcess; i++) {
                if (process[i].AT <= time && (process[i].remBT < min && process[i].remBT > 0)) {
                    shortest = i;
                    min = process[i].remBT;
                    check = true;
                }
            }

            if (!check) {
                time++;
                continue;
            }
            process[shortest].remBT--;
            min = process[shortest].remBT;

            if (min == 0) {
                min = Integer.MAX_VALUE;
                count++;
                sum = time + 1;
                process[shortest].CT = sum;
                process[shortest].TAT = process[shortest].CT - process[shortest].AT;
                process[shortest].WT = process[shortest].TAT - process[shortest].BT;

                avgWT = avgWT + process[shortest].WT;
                avgTAT = avgTAT + process[shortest].TAT;

                process[shortest].display();
            }
            time++;

        }

        avgTAT = avgTAT / numProcess;
        avgWT = avgWT / numProcess;
        System.out.println("Average Waiting Time" + avgWT);
        System.out.println("Average TAT=" + avgTAT);
    }
}

class PriorityNonPreemptive {

    private Scanner sc;

    public void execute() {
        sc = new Scanner(System.in);

        System.out.println("Enter Number of Processes:");
        int numProcess = sc.nextInt();
        Process[] process = new Process[numProcess];

        for (int i = 0; i < numProcess; i++) {
            System.out.println("P(" + (i + 1) + "):Enter  Burst time  & priority");
            int at = 0;
            int bt = sc.nextInt();
            int priority = sc.nextInt();
            process[i] = new Process("P" + (i + 1), bt, at, priority);
        }

        Arrays.sort(process, new SortByPriority());

        int sum = 0;
        double avgWT = 0, avgTAT = 0;
        System.out.println("\n\nPRNo\tBT\tAT\tCT\tTAT\tWT\tPR");
        System.out.println("============================================================================================");
        for (int i = 0; i < numProcess; i++) {
            sum = process[i].CT = sum + process[i].BT;
            process[i].TAT = process[i].CT - process[i].AT;
            process[i].WT = process[i].TAT - process[i].BT;

            avgWT = avgWT + process[i].WT;
            avgTAT = avgTAT + process[i].TAT;

            process[i].display();
        }

        avgTAT = avgTAT / numProcess;
        avgWT = avgWT / numProcess;
        System.out.println("Average Waiting Time" + avgWT);
        System.out.println("Average TAT=" + avgTAT);
    }
}

class RoundRobin {

    private Scanner sc;

    public void execute() {
        sc = new Scanner(System.in);

        System.out.println("Enter Number of Processes:");
        int numProcess = sc.nextInt();
        Process[] process = new Process[numProcess];

        for (int i = 0; i < numProcess; i++) {
            System.out.println("P(" + (i + 1) + "):Enter Arrival time & Burst time");
            int at = sc.nextInt();
            int bt = sc.nextInt();

            process[i] = new Process("P" + (i + 1), bt, at);
        }
        Arrays.sort(process, new SortByArrival());

        System.out.println("Enter Quantum Time: ");
        int quantum = sc.nextInt();

        double avgWT = 0, avgTAT = 0;
        int time = 0;
        System.out.println("\n\nPRNo\tBT\tAT\tCT\tTAT\tWT\tPR");
        System.out.println("============================================================================================");
        while (true) {
            boolean done = true;
            for (int i = 0; i < numProcess; i++) {
                if (process[i].remBT > 0 && process[i].AT <= time) {
                    done = false;

                    if (process[i].remBT > quantum) {
                        time = time + quantum;
                        process[i].remBT = process[i].remBT - quantum;
                        System.out.println("Running Process " + process[i].name + " from" + (time - quantum) + " to " + time);
                    } else {
                        time += process[i].remBT;
                        System.out.println("Running Process " + process[i].name + " " + (time - process[i].remBT) + " TIME " + time);

                        process[i].remBT = 0;
                        process[i].CT = time;
                        process[i].TAT = process[i].CT - process[i].AT;
                        process[i].WT = process[i].TAT - process[i].BT;
                        avgWT += process[i].WT;
                        avgTAT += process[i].TAT;
                        System.out.println("Completed Process " + process[i].name);
                        process[i].display();
                    }
                }
            }
            if (done) {
                break;
            }
        }

        System.out.println("Average Waiting Time" + avgWT / numProcess);
        System.out.println("Average TAT=" + avgTAT / numProcess);
    }
}

class Assignment1 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int ch = 0;

        while (ch != -1) {
            System.out.println("CPU SCHEDULING ALGORITHMS");
            System.out.println("\n1.FCFS\n2.SJF\n3.PriorityNonPreemptive\n4.Round Robin\nENTER: ");
            ch = sc.nextInt();
            try {

                switch (ch) {
                    case 1: {
                        FCFS fcfs = new FCFS();
                        fcfs.execute();
                        break;
                    }
                    case 2: {
                        SJF sjf = new SJF();
                        sjf.execute();
                        break;
                    }
                    case 3: {
                        PriorityNonPreemptive pr = new PriorityNonPreemptive();
                        pr.execute();
                        break;
                    }
                    case 4: {
                        RoundRobin rr = new RoundRobin();
                        rr.execute();
                        break;
                    }
                    case -1:
                        sc.close();
                        break;
                    default:
                        throw new IllegalArgumentException("Unexpected value: " + ch);
                }
            } catch (Exception e) {
                System.out.println("Unexpected Value");
            }
        }
    }
}