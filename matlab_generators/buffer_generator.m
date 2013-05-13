function buffer_generator(n)
    
    %Make Sure n is an odd number
    if mod(n,2) == 0
        fprintf('n must be an odd number!\n');
        return;
    end

    filename = strcat('buffer',int2str(n),'.v');
    fprintf('Creating Kernel File, %s, with %d lines...\n',filename,n); 
    fileID = fopen(filename','w');

    %Comment the File
    fprintf(fileID, '//%d line buffer\n',n);
    
    %start the module
    fprintf(fileID, 'module buffer%d(\n',n);
        fprintf(fileID,'\tclock,\n\tclken,\n\tshiftin,\n\tshiftout,\n\toGrid);\n\n');
        fprintf(fileID,'\tinput\twire\tclock, clken;\n');
        fprintf(fileID,'\tinput\twire\tshiftin;\n');
        fprintf(fileID,'\tinteger\ti;\n');
        fprintf(fileID,['\toutput\twire [', int2str(n^2 - 1), ':0] oGrid;\n']);
        fprintf(fileID,'\toutput\treg  shiftout;\n');
        
        %make all the line registers
        for a = 1:n
            fprintf(fileID,'\treg line%d [639:0];\n',a);
        end
        
        fprintf(fileID,'\tassign oGrid={');
        for a = 1:n
            for b = 1:n
                fprintf(fileID,'line%d[%d]',a,640-b);
                if (a ~= n || b ~= n)
                    fprintf(fileID,',');
                end
            end
            fprintf(fileID,'\n\t\t\t');
            
        end
        fprintf(fileID,'};\n');
        
        fprintf(fileID,'\talways @ (posedge clock) begin\n');
            fprintf(fileID,'\t\tif(clken)\n\t\tbegin\n');
                fprintf(fileID,'\t\t\tline1[0] <= shiftin;\n');
                for a = 2:n
                    fprintf(fileID,'\t\t\tline%d[0] <= line%d[639];\n',a,a-1);
                end
                fprintf(fileID,'\t\t\tfor(i=1;i<640;i=i+1)\n\t\t\tbegin\n');
                for a = 1:n
                    fprintf(fileID,'\t\t\t\tline%d[i] <= line%d[i-1];\n',a,a);
                end
                fprintf(fileID,'\t\t\tend\n');
                
                fprintf(fileID,['\t\t\tshiftout <= line',int2str(ceil(n/2)),'[',int2str(640-ceil(n/2)),'];\n']);
            fprintf(fileID,'\t\tend\n\t\telse\n\t\tbegin\n');
                fprintf(fileID,'\t\t\tfor(i=0;i<640;i=i+1)\n\t\t\tbegin\n');
                    for a = 1:n
                        fprintf(fileID,'\t\t\t\tline%d[i] <= line%d[i];\n',a,a);
                    end
                fprintf(fileID,'\t\t\tend\n');
                fprintf(fileID,'\t\t\tshiftout <= shiftout;\n');
            
            fprintf(fileID,'\t\tend\n');
            
         fprintf(fileID,'\tend\n');       
                    
    %end the module
    fprintf(fileID, 'endmodule\n');
    
    fprintf('File Created!\n');
    
end
