import {
  aws_logs as logs,
  RemovalPolicy,
  aws_stepfunctions_tasks as tasks,
  aws_stepfunctions as sfn,
  Duration,
} from 'aws-cdk-lib';

import { CdkStack } from '../cdk-stack';
import { StackProps } from '../stack-props';

import { useCapitalize } from '../utils/useCapitalize';
import { buildFetchRecentEpisodeLambda } from './buildFetchRecentEpisodeLambda';
import { buildCreateNewEpisodeShowNoteLambda } from './buildCreateNewEpisodeShowNoteLambda';

const { capitalize } = useCapitalize();

export const buildCreateNewShowNoteStateMachine = (stack: CdkStack, props: StackProps) => {
  const logGroupName = `/aws/vendedlogs/states/CreateNewShowNoteStateMachine${capitalize(props.stage)}`;
  const logGroup = new logs.LogGroup(stack, `CreateNewShowNoteStateMachineLogGroup${capitalize(props.stage)}`, {
    logGroupName,
    removalPolicy: RemovalPolicy.DESTROY,
  });

  const fetchRecentEpisodeLambda = buildFetchRecentEpisodeLambda(stack, props);
  const fetchRecentEpisodeTask = new tasks.LambdaInvoke(stack, `FetchRecentEpisodeTask${capitalize(props.stage)}`, {
    lambdaFunction: fetchRecentEpisodeLambda,
  });

  const createNewEpisodeShowNoteLambda = buildCreateNewEpisodeShowNoteLambda(stack, props);
  const createNewEpisodeShowNoteTask = new tasks.LambdaInvoke(
    stack,
    `CreateNewEpisodeShowNoteTask${capitalize(props.stage)}`,
    {
      lambdaFunction: createNewEpisodeShowNoteLambda,
    },
  );

  const definition = fetchRecentEpisodeTask.next(createNewEpisodeShowNoteTask);

  return new sfn.StateMachine(stack, `CreateNewShowNoteStatemachine${capitalize(props.stage)}`, {
    definitionBody: sfn.DefinitionBody.fromChainable(definition),
    logs: {
      destination: logGroup,
    },
    timeout: Duration.minutes(5),
  });
};
