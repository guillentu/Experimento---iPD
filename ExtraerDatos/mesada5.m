mediaXsujeto_T5=_mediaXsujeto;
timeOutMedia_T5=_timeOutMedia;
foodMedia_T5=foodMedia;
promediosC_T5=_promediosC;
timeOutSem_T5=_timeOutSem;
foodSem_T5=foodSem;
semXsujeto_T5=_stdXsujeto;
timeOut_T5=_timeOut;
food_T5=food;

mediaXsujeto_T3=_mediaXsujeto;
timeOutMedia_T3=_timeOutMedia;
foodMedia_T3=foodMedia;
promediosC_T3=_promediosC;
timeOutSem_T3=_timeOutSem;
foodSem_T3=foodSem;
semXsujeto_T3=_semXsujeto;
timeOut_T3=_timeOut;
food_T3=food;

mediaXsujeto_T2=_mediaXsujeto;
timeOutMedia_T2=_timeOutMedia;
foodMedia_T2=foodMedia;
promediosC_T2=_promediosC;
timeOutSem_T2=_timeOutSem;
foodSem_T2=foodSem;
semXsujeto_T2=_semXsujeto;
timeOut_T2=_timeOut;
food_T2=food;
% RESERSION
mediaXsujeto_T2r=_mediaXsujeto;
timeOutMedia_T2r=_timeOutMedia;
foodMedia_T2r=foodMedia;
promediosC_T2r=_promediosC;
timeOutSem_T2r=_timeOutSem;
foodSem_T2r=foodSem;
semXsujeto_T2r=_stdXsujeto;
timeOut_T2r=_timeOut;
food_T2r=food;

save('-mat7-binary','datos_coop_reward_T2r.mat','mediaXsujeto_T2r','timeOutMedia_T2r','foodMedia_T2r','promediosC_T2r',...
         'timeOutSem_T2r','foodSem_T2r','semXsujeto_T2r','timeOut_T2r','food_T2r');
save('datos_coop_reward_T2r','mediaXsujeto_T2r','timeOutMedia_T2r','foodMedia_T2r','promediosC_T2r',...
         'timeOutSem_T2r','foodSem_T2r','semXsujeto_T2r','timeOut_T2r','food_T2r');

save('-mat7-binary','datos_coop_reward_T3.mat','mediaXsujeto_T3','timeOutMedia_T3','foodMedia_T3','promediosC_T3',...
         'timeOutSem_T3','foodSem_T3','semXsujeto_T3','timeOut_T3','food_T3');
save('datos_coop_reward_T3','mediaXsujeto_T3','timeOutMedia_T3','foodMedia_T3','promediosC_T3',...
         'timeOutSem_T3','foodSem_T3','semXsujeto_T3','timeOut_T3','food_T3');
         
save('-mat7-binary','datos_coop_reward_T4.mat','mediaXsujeto_T4','timeOutMedia_T4','foodMedia_T4','promediosC_T4',...
         'timeOutSem_T4','foodSem_T4','semXsujeto_T4','timeOut_T4','food_T4');
save('datos_coop_reward_T4','mediaXsujeto_T4','timeOutMedia_T4','foodMedia_T4','promediosC_T4',...
         'timeOutSem_T4','foodSem_T4','semXsujeto_T4','timeOut_T4','food_T4');
         
save('-mat7-binary','datos_coop_reward_T5.mat','mediaXsujeto_T5','timeOutMedia_T5','foodMedia_T5','promediosC_T5',...
         'timeOutSem_T5','foodSem_T5','semXsujeto_T5','timeOut_T5','food_T5');
save('datos_coop_reward_T5','mediaXsujeto_T5','timeOutMedia_T5','foodMedia_T5','promediosC_T5',...
         'timeOutSem_T5','foodSem_T5','semXsujeto_T5','timeOut_T5','food_T5');
         
R2_T2=R2;
R_mean_T2=R_mean;
save('-mat7-binary','datos_coopmutua_T2.mat','R2_T2','R_mean_T2');
save('datos_coopmutua_T2','R2_T2','R_mean_T2');
         
R2_T3=R2;
R_mean_T3=R_mean;
save('-mat7-binary','datos_coopmutua_T3.mat','R2_T3','R_mean_T3');
save('datos_coopmutua_T3','R2_T3','R_mean_T3');

R2_T4=R2;
R_mean_T4=R_mean;
save('-mat7-binary','datos_coopmutua_T4.mat','R2_T4','R_mean_T4');
save('datos_coopmutua_T4','R2_T4','R_mean_T4');
