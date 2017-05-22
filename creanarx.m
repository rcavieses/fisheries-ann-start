function [netc,net]=creanarx(InputTrain, TargTrain,ID,HLS)
inputSeries = InputTrain;
targetSeries = TargTrain;
inputDelays = 1:ID;
feedbackDelays = 1:ID;
hiddenLayerSize = HLS;
net = narxnet(inputDelays,feedbackDelays,hiddenLayerSize);
[inputs,inputStates,layerStates,targets] = preparets(net,inputSeries,{},targetSeries);

net.divideParam.trainRatio = 90/100;
net.divideParam.valRatio = 5/100;
net.divideParam.testRatio = 5/100;

net = train(net,inputs,targets,inputStates,layerStates);

netc = closeloop(net);
netc.name = [net.name ' - Closed Loop'];
end
