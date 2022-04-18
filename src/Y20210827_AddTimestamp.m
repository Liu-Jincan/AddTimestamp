clc,clear all
%% fileFolder path
fileFolder = uigetdir;
cd(fileFolder);
files = dir('*'); 
%{ 
1. Can name files with Spaces
2. '.'
%}

%% rename
for i=3:length(files) % The first and second rows are not usable
    oldName = files(i).name;
    try % Turn the fist ' ' into '~~'
        if oldName(5)=='-' && oldName(8)=='-' && oldName(11)==32
            tempOldName = strcat(oldName(1:10),'~~',oldName(12:end))
        else
            tempOldName = oldName;
        end
    end
    
    try %timeStamp = strcat(files(3).date(7:10),files(3).date(7:10));
        tempNum = regexp(files(i).date,'\d*\.?\d*','match'); % refer: {https://zhuanlan.zhihu.com/p/128130641}
        num = str2double(tempNum); %    
        year = num2str(num(3));
        if num(2)<10
            month = strcat('0',num2str(num(2)));
        else
            month = num2str(num(2));
        end
        if num(1)<10
            day = strcat('0',num2str(num(1)));
        else
            day = num2str(num(1));
        end
        timeStamp = strcat(year,'-',month,'-',day);
    end
    newName = strcat(timeStamp,'~~',tempOldName); 
    
    while find(newName=='.')-1>=24 % Delete the duplicate timestamp, & The case where the name is not updated
        if strcmp(newName(1:12),newName(13:24)) || (strcmp(newName(11:12),'~~')&&strcmp(newName(23:24),'~~'))
            newName = newName(13:end);
        else 
            break;
        end
    end
    
    
    if length(find(oldName=='.'))~=0
        ind = find(oldName=='.');
        s1 = oldName(ind+1:end);
        s2 = {'txt','bmp','doc','docx','pdf','xlsx','vcf','pptx','jpg','png',...
            'bmp','exe','zip','rar','mkv','mp4','prj','html','htm','vsdx','ini','iso','mp3'}; % These types of files are the ones that add the timestamp
        if sum(strcmp(s1,s2))~=0 && strcmp(oldName,newName)==0
            %eval(['!rename' 32 oldName 32 newName]); % The number 32 represents the space in the string, but Cannot name files with Spaces
            % movefile(oldName,newName); % Can name files with Spaces
            movefile(oldName,newName,'f'); % 
        end
    end


end
