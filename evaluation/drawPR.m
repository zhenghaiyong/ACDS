function drawPR()
InputResults = './pr/';
customColor = cell(10,1);

customColor{1, 1}=[1 0 1];%'m' 'magenta'
customColor{2, 1}=[0 1 1];%'c' 'cyan'
customColor{3, 1}=[0 1 0];%'g' 'green'
customColor{4, 1}=[0 0 1];%'b' 'blue'
customColor{5, 1}=[0.7 0.7 0];
customColor{6, 1}=[0.7 0 1];
customColor{7, 1}=[1 0 0];%'r' 'red'
customColor{8, 1}=[0.5 0.5 0.5];
customColor{9, 1}=[0 0 0];%'k' 'black'
customColor{10, 1}=[1 1 0];%'y' 'yellow'


traverse(InputResults, customColor);

function traverse(InputResults, customColor)
idsResults = dir(InputResults);
for i = 3:length(idsResults)
    if idsResults(i, 1).isdir==1
        traverse(strcat(InputResults, idsResults(i, 1).name,'/'), customColor);
    else
        figure;hold on;
        numColor=1;
        for curMatNum = 3:length(idsResults)
            if strcmp(idsResults(curMatNum, 1).name((end-3):end), '.mat')
            load(strcat(InputResults, idsResults(curMatNum, 1).name));
            lh = plot(recall, precision, 'LineWidth', 2);
            set(lh,'Color',customColor{numColor,1});
            numColor=numColor+1;
            else
                continue;
            end
        end
        series=regexp(InputResults,'/');
        titlename=InputResults((series(end-1)+1):(series(end)-1));
        title(titlename,'FontName','Times');
        legend_handle=legend('ITTI','SR','PQFT','SIG','HFT','RC','IG','S','IG+S');
        set(legend_handle,'Location','SouthWest','FontName','Times');
        xlabel('Recall','FontName','Times');
        ylabel('Precision','FontName','Times');
        set(gca,'FontName','Times');
        set(gcf,'paperpositionmode','auto');
        grid;
        % (r,p) for single binarization by threshold=expectation+10
        %plot(0.8783,0.8484,'p','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
        print('-dtiff','-r1000',[InputResults, strcat('pr-',titlename,'.tif')]);
        break;
    end
end
