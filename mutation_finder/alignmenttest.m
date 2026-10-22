prompt='What is the name of the file(leave first line empty) containing sequences? \n';
%p53= fastaread('class_A_single_organism_2.fasta')   %READ THE FASTA FILE
seqfilename=input(prompt,'s');
p53=fastaread(seqfilename);
dist = seqpdist(p53,'ScoringMatrix','GONNET');      %Compute the pairwise distances between each pair of sequences using the 'GONNET' scoring matrix.
tree = seqlinkage(dist,'average',p53);               %Build a phylogenetic tree using an unweighted average distance (UPGMA) method. This tree will be used as a guiding tree in the next step of progressive alignment.
ma = multialign(p53,tree,'ScoringMatrix',...1       %Perform progressive alignment using the PAM family scoring matrices
                {'pam150','pam200','pam250'});
          
  size_ma=size(ma);
  proteins=size_ma(1);
   aa=size(ma(1).Sequence);
   
   multialignwrite('p54.aln',ma)
  for i=1:proteins
     for j=1:aa(2)
         seq(i,j) =  ma(i).Sequence(j);
         location(i,j)=0;
     end
    % header(i)=ma(i).Header;
  end
  for i=1:aa(2)
      counter(i)=0;
      counter_A(i)=0;
      counter_C(i)=0;
      counter_D(i)=0;
      counter_E(i)=0;
      counter_F(i)=0;
      counter_G(i)=0;
      counter_H(i)=0;
      counter_I(i)=0;
      counter_K(i)=0;
      counter_L(i)=0;
      counter_M(i)=0;
      counter_N(i)=0;
      counter_P(i)=0;
      counter_Q(i)=0;
      counter_R(i)=0;
      counter_S(i)=0;
      counter_T(i)=0;
      counter_V(i)=0;
      counter_W(i)=0;
      counter_Y(i)=0;
      counter_GAP(i)=0;
      
      
  end
  
  for i=1:aa(2)
      for j=1:proteins
          if seq(j,i)==seq(1,i)
              counter(i)=counter(i)+1;
              location(j,i)=1;
          end
          if seq(j,i)=='A'
          counter_A(i)=counter_A(i)+1;
          end
           if seq(j,i)=='C'
          counter_C(i)=counter_C(i)+1;
           end
           if seq(j,i)=='D'
          counter_D(i)=counter_D(i)+1;
           end
           if seq(j,i)=='E'
          counter_E(i)=counter_E(i)+1;
           end
           if seq(j,i)=='F'
          counter_F(i)=counter_F(i)+1;
           end
           if seq(j,i)=='G'
          counter_G(i)=counter_G(i)+1;
           end
           if seq(j,i)=='H'
          counter_H(i)=counter_H(i)+1;
           end
           if seq(j,i)=='I'
          counter_I(i)=counter_I(i)+1;
           end
           if seq(j,i)=='K'
          counter_K(i)=counter_K(i)+1;
          end
           if seq(j,i)=='L'
          counter_L(i)=counter_L(i)+1;
           end
           if seq(j,i)=='M'
          counter_M(i)=counter_M(i)+1;
          end
          if seq(j,i)=='N'
          counter_N(i)=counter_N(i)+1;
          end
          if seq(j,i)=='P'
          counter_P(i)=counter_P(i)+1;
          end
          if seq(j,i)=='Q'
          counter_Q(i)=counter_Q(i)+1;
          end
           if seq(j,i)=='R'
          counter_R(i)=counter_R(i)+1;
           end
           if seq(j,i)=='S'
          counter_S(i)=counter_S(i)+1;
           end
           if seq(j,i)=='T'
          counter_T(i)=counter_T(i)+1;
           end
           if seq(j,i)=='V'
          counter_V(i)=counter_V(i)+1;
           end
           if seq(j,i)=='W'
          counter_W(i)=counter_W(i)+1;
           end
           if seq(j,i)=='Y'
          counter_Y(i)=counter_Y(i)+1;
           end
           if seq(j,i)=='-'
          counter_GAP(i)=counter_GAP(i)+1;
          end
        
      end
  end   

  
no_of_mutations=proteins-counter;
aa_list=['A';'C';'D';'E';'F';'G';'H';'I';'K';'L';'M';'N';'P';'Q';'R';'S';'T';'V';'W';'Y';'-'];
mut_aa_wise=[counter_A;counter_C;counter_D;counter_E;counter_F;counter_G;counter_H;counter_I;counter_K;counter_L;counter_M;counter_N;counter_P;counter_Q;counter_R;counter_S;counter_T;counter_V;counter_W;counter_Y;counter_GAP];



% fid = fopen( 'matrix.csv', 'w' );
% for jj = 1 : length( aa_list )
%     fprintf( fid, '%s,', aa_list(jj));
%     for i=1:aa(2)
%         fprintf( fid,'%d,', mut_aa_wise(jj,i));
%         if(i==aa(2))
%             fprintf(fid,'\n');
%         end
%     end
% end
% 
% 
% fclose( fid );

fid2= fopen('final_combined.csv','w');
fprintf(fid2,'amino Acid Numbering,');
counter_no=2;
for i=1:aa(2)
    if seq(1,i)~='-'
       if counter_no==238 || counter_no==252
           counter_no=counter_no+1;
       end
        counter_no=counter_no+1;
        fprintf(fid2,'%d,',counter_no);
    else
        fprintf(fid2,' ,');
    end
end
fprintf(fid2,'\n');
for i=1: proteins
    fprintf(fid2,'%s,',ma(i).Header);
    for j=1:aa(2)
        fprintf(fid2,'%s,',seq(i,j));
        if(j==aa(2))
            fprintf(fid2,'\n');
        end
    end
end
fprintf(fid2,'The no of mutations-,');
for i=1:aa(2)
    fprintf(fid2,'%d,',no_of_mutations(i));
end
fprintf(fid2,'\n \n');
for jj = 1 : length( aa_list )
    fprintf( fid2, '%s,', aa_list(jj));
    for i=1:aa(2)
        fprintf( fid2,'%d,', mut_aa_wise(jj,i));
        if(i==aa(2))
            fprintf(fid2,'\n');
        end
    end
end
fclose(fid2);
sp=' ';
fid3=fopen('mutation_dat.csv','w');
fprintf(fid2,'amino Acid Numbering,');
counter_no=2;
number_aa=zeros(1,aa(2));
for i=1:aa(2)
    if seq(1,i)~='-'
         if counter_no==238 || counter_no==252
           counter_no=counter_no+1;
       end
        counter_no=counter_no+1;
        number_aa(i)=counter_no;
        fprintf(fid2,'%d,',counter_no);
    else
        fprintf(fid2,' ,');
    end
end
fprintf(fid2,'\n');
fprintf(fid3,'%s,',ma(1).Header);
for j=1:aa(2)
    fprintf(fid3,'%s,',seq(1,j));
end
fprintf(fid3,'\n');
for i=2:proteins
    fprintf(fid3,'%s,',ma(i).Header);
    for j=1:aa(2)
        if(seq(i,j)==seq(1,j))
            fprintf(fid3,'%s,',sp);
        else
            fprintf(fid3,'%s,',seq(i,j));
        end
         if(j==aa(2))
            fprintf(fid3,'\n');
        end
    end
end
fprintf(fid3,'The no of mutations-,');
for i=1:aa(2)
    fprintf(fid3,'%d,',no_of_mutations(i));
end
fclose(fid3);
fid4=fopen('mutations_acc_to_enzymes.csv','w');
for i=2:proteins
    fprintf(fid4,'%s,',ma(i).Header);
    for j=1:aa(2)
        if number_aa(j)~=0 & location(i,j)==0
            fprintf(fid3,'%s%d%s,',seq(1,j),number_aa(j),seq(i,j));
        end
    end
    fprintf(fid4,'\n');
end
fclose(fid4);
fid5=fopen('ncf_data.csv','w');
fprintf(fid5,'%s,',ma(1).Header);
fprintf(fid5,'aa,');
for i=1:21
    fprintf(fid5,'%s,',aa_list(i));
end
fprintf(fid5,'\n')

% for j=1:aa(2)
%     fprintf(fid5,'%s,',seq(1,j));
% end
for i=1:aa(2)
    counter_cutoff=0;
    for j=1:20
        if mut_aa_wise(j,i)>2
            counter_cutoff=counter_cutoff+1;
        end
    end
        if counter_cutoff >= 2
            
            fprintf(fid5,'%d,%s,',number_aa(i),seq(1,i));
            for k=1:21
                fprintf(fid5,'%d,',mut_aa_wise(k,i));
            end
            fprintf(fid5,'\n');
        end
end
fclose(fid5);
fid5=fopen('ncf_data2.csv','w');

fprintf(fid5,'%s,',ma(1).Header);
fprintf(fid5,'aa,');
for i=1:21
    fprintf(fid5,'%s,',aa_list(i));
end
fprintf(fid5,'\n')


for i=1:aa(2)
    counter_cutoff=0;
    for j=1:20
        if mut_aa_wise(j,i)>5
            counter_cutoff=counter_cutoff+1;
        end
    end
        if counter_cutoff >= 2
            
            fprintf(fid5,'%d,%s,',number_aa(i),seq(1,i));
            for k=1:21
                fprintf(fid5,'%d,',mut_aa_wise(k,i));
            end
            fprintf(fid5,'\n');
        end
end
fclose(fid5);

%fid6=fopen
%         
% filename = 'write.csv';
% %writetable(seq,'write.xls')
% 
% sheet=1;
%  xlrange='B169';
%  csvwrite('seq.csv',seq)
%  csvwrite('no_of_mutations.csv',no_of_mutations)
%  csvwrite('mut_aa_wise.csv',mut_aa_wise)
%  csvwrite('aa_list.csv',aa_list)
%  
%  csvwrite('write.csv',no_of_mutations,168,0);
%  csvwrite('write.csv',seq,0,0);
%  csv_aalist=csvread('aa_list.csv');
%  csv_mut_aa_wise=csvread('mut_aa_wise.csv');
%  csv_combined1=[csv_aalist;csv_mut_aa_wise];
%  csvwrite('mutation.csv',csv_combined1);
%  csv_seq=csvread('seq.csv');
%  csv_no_of_mutations=csvread('no_of_mutations');
%  csv_combined2=[csv_seq,csv_no_of_mutations];
%  csvwrite('seq_mutations.csv',csv_combined2);



%ma(169).Header= 'No of mutations';
% for i=1:aa(2)
%   char_value=int2str(counter(i));
%   c(i)=char_value;
% end
%ma(169).Sequence=c;
showalignment(ma)
% savefig('PeaksFile.fig')
%struct2File( ma, 'exp.txt', 'align', true, 'sort', false );