function w = wf_calc (wto)
global s H
w = wto * (1-exp(-s/H)+0.015);
end