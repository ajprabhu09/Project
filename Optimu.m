CarData=csvread('Data.csv',1,0);
len=size(CarData);
for l= 1:len(1)
    
dist=CarData(l,1); %distance from the upcoming signal.
signal=CarData(l,2);% 0->red 1->amber 2->green 
tloncurrentsignal=CarData(l,5);% time left on the current signal which is green(add)
n=CarData(l,6);%number of lanes in the upcoming signal junciton(add)
k=0;%for while loop %% fixed
csln=CarData(l,7); % current signal lane number. This will always be 0 for the lane in which you are and 
       % then changes by one with every lane in clockwise direction(add)
jt=60; %time of green for each lane
vg=25;
timeMargin=3;
 
    
if signal==2
    v=dist*5/((tloncurrentsignal-timeMargin)*18);
    if v>60
        v1=v;
        while v1>60
            v1=dist*5/((tloncurrentsignal-timeMargin+(k*.01*(n)*jt+(n-1)*jt*0.01)*18));
            k=k+1;
            
        end
        vg=v1;
        
    elseif v>5 & v<60
        vg=dist*5/((tloncurrentsignal-timeMargin)*18);
    elseif v<5
        vg=25;
    end
elseif signal==1
    pause(1)
elseif signal==0
    v=dist*5/((tloncurrentsignal-timeMargin)+(rem(n-csln-1,n)*jt)*18);
    if dist<10
        vg=0;
    elseif v>60
        v1=dist*5/((tloncurrentsignal+(rem(n-csln-1,n)*jt+(n*jt)))*18);
        while v1>60
            v1=dist*5/((tloncurrentsignal+(rem(n-csln-1,n)*jt+(k*n*jt)))*18);
            k=k+1;
        end
        vg=v1;
    elseif v>5 & v<60
        vg=dist*5/((tloncurrentsignal-timeMargin)+(rem(n-csln-1,n)*jt)*18);
    elseif v<5
        vg=25;
    end
end
Xtest = CarData(l,1:8);

nnsout=net(Xtest');
trafficDensity=CarData(l,8);
disp(['Speed:',num2str(trafficDensity*nnsout(1)+(1-trafficDensity)*vg)]);
disp(['Accelaration:',num2str(nnsout(2))]);
disp('----------------------------------')

end
.............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................