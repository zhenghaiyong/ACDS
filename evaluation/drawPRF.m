function drawPRF()
InputResults = './prf/';
traverse(InputResults);

function traverse(InputResults)
idsResults = dir(InputResults);
for i = 3:length(idsResults)
    if idsResults(i, 1).isdir==1
        traverse(strcat(InputResults, idsResults(i, 1).name,'/'));
    else
        for curMatNum = 3:length(idsResults)
            if strcmp(idsResults(curMatNum, 1).name((end-3):end), '.mat')
                load(strcat(InputResults, idsResults(curMatNum, 1).name));
            else
                continue;
            end
        end
        bar_all=[precision_1Canny,recall_1Canny,Fmeasure_1Canny;precision_2ITS,recall_2ITS,Fmeasure_2ITS;...
            precision_3Otsu,recall_3Otsu,Fmeasure_3Otsu;precision_4MET,recall_4MET,Fmeasure_4MET;...
            precision_5Kmeans,recall_5Kmeans,Fmeasure_5Kmeans;...
            precision_6SalientObjectsSegmentation,recall_6SalientObjectsSegmentation,Fmeasure_6SalientObjectsSegmentation;...
            precision_7RemoveCornerNoise,recall_7RemoveCornerNoise,Fmeasure_7RemoveCornerNoise;...
            precision_8WatershedFromMarkers,recall_8WatershedFromMarkers,Fmeasure_8WatershedFromMarkers];
        bar(bar_all,'group');
        series=regexp(InputResults,'/');
        titlename=InputResults((series(end-1)+1):(series(end)-1));
        title(titlename,'FontName','Times');
        legend_handle=legend('Precision','Recall','F-measure');
        set(legend_handle,'Location','SouthWest','FontName','Times');
        set(gca,'XGrid','on','XTickLabel',{'Canny','ITS','Otsu','MET','Kmeans','Ours1','Ours2','Ours3'},'FontName','Times');
        set(gcf,'paperpositionmode','auto');
        grid;
        print('-dtiff','-r1000',[InputResults, strcat('prf-',titlename,'.tif')]);
        break;
    end
end
