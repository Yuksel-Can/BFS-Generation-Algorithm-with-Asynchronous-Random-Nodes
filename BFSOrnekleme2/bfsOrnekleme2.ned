import ned.DelayChannel;

simple node
{
    @display("i=device/laptop");
    gates:
        inout gate[];
}
channel wired extends DelayChannel
{
    @display("ls=#4E9A06,2,s");
    delay = 100ms;
}
network bfsTabanliNetwork
{
    parameters:
        
        int n @prompt("Number of nodes") = default(80);
        volatile int posX = intuniform (100,2000);
        volatile int posY = intuniform (100,2000);
        volatile int random = intuniform (0,78);
        volatile int random2 = intuniform (0,78); 
        @display("bgb=2200,2200");
    submodules:
        
        nodeStart: node {
            @display("p=50,50");
        }
        node[n]: node {
            @display("p=$posX,$posY");
        }
	connections allowunconnected:
	    
	    for i= 0..n-1{
	        node[i].gate++ <--> {  delay = 11ms*random; } <--> node[random].gate++  if i!=random;
	        node[i].gate++ <--> {  delay = 10ms*random; } <--> node[random2].gate++ if i!=random2;
	    }
		nodeStart.gate++ <--> {  delay = 101ms; }<--> node[0].gate++;
}

