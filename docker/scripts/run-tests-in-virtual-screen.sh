#!/bin/sh
HOME=${ROBOT_WORK_DIR}
if [ "${Rerun}" -eq "1" ]
then
    echo  hii
else
    Rerun=0
fi
if [ "${TAG_RERUN}" -eq "1" ]
then
    echo  Test
else
    TAG_RERUN=0
fi
if [ "${MergeOutput}" -eq "1" ]
then
    echo  hii
else
    MergeOutput=0
fi
# No need for the overhead of Pabot if no parallelisation is required
if [ $ROBOT_THREADS -eq 1 -a ${Rerun} -eq 0 -a ${MergeOutput} -eq 0  ]
then
    xvfb-run \
        --server-args="-screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_COLOUR_DEPTH} -ac" \
        robot \
        --outputDir $ROBOT_REPORTS_DIR \
        ${ROBOT_OPTIONS} \
        $ROBOT_TESTS_DIR \
        
elif [ $ROBOT_THREADS -ne 1 -a ${Rerun} -eq 0 -a ${MergeOutput} -eq 0 ]
    then
    xvfb-run \
        --server-args="-screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_COLOUR_DEPTH} -ac" \
        pabot \
        --verbose \
        --processes $ROBOT_THREADS \
        ${PABOT_OPTIONS} \
        --outputDir $ROBOT_REPORTS_DIR \
        ${ROBOT_OPTIONS} \
        $ROBOT_TESTS_DIR \
        
elif [ ${Rerun} -eq 1 -a ${MergeOutput} -eq 0 ]  
    then
        echo $ROBOT_REPORTS_DIR
        cd  $ROBOT_REPORTS_DIR
        xvfb-run \
            --server-args="-screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_COLOUR_DEPTH} -ac" \
            pabot   \
            --verbose \
             --suitesfrom \
             --processes=$ROBOT_THREADS \
            --rerunfailed=output.xml \
            --output=rerun.xml  \
            ${PABOT_OPTIONS} \
            $ROBOT_TESTS_DIR 
 
    rebot --nostatusrc --outputdir $ROBOT_REPORTS_DIR --output output.xml --merge $ROBOT_REPORTS_DIR/output.xml  $ROBOT_REPORTS_DIR/rerun.xml
fi

if [ ${TAG_RERUN} -eq 1 -a ${MergeOutput} -eq 0 ]
    then
        echo "line no 74"
        echo $ROBOT_REPORTS_DIR
        cd  $ROBOT_REPORTS_DIR
        xvfb-run \
            --server-args="-screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_COLOUR_DEPTH} -ac" \
            pabot   \
            --verbose \
             --suitesfrom \
             --processes=$ROBOT_THREADS \
            --rerunfailed=output.xml \
            --output=rerun.xml  \
            ${PABOT_OPTIONS} \
            $ROBOT_TESTS_DIR 
            rebot --nostatusrc --outputdir $ROBOT_REPORTS_DIR --output output.xml --merge $ROBOT_REPORTS_DIR/output.xml  $ROBOT_REPORTS_DIR/rerun.xml
    fi


   if [ ${MergeOutput} -eq 1 ] 
        then
            rebot -R --xunit outputNew.xml $ROBOT_REPORTS_DIR/output*.xml   


        fi




