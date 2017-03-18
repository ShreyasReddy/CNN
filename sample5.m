function output_fm = sample5( input,weight,p)
out=0;

for i=0:8
    for j=0:2
        for h=1:9

        output=(input(1,((i*9)+(j*81)+h)).*weight(1,((i*9)+(j*81)+h)));
        out=out+output;
        end     
    end 
   p(i+1)=out;
   output=0;
   out=0;    
end

output_fm=p;


end

