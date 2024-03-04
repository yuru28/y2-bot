import { aws_stepfunctions as sfn, aws_events as events, aws_events_targets as targets } from 'aws-cdk-lib';

import { CdkStack } from '../cdk-stack';
import { StackProps } from '../stack-props';

import { useCapitalize } from '../utils/useCapitalize';

export const buildExecutionRuleForCreateNewShowNoteStateMachine = (
  stack: CdkStack,
  props: StackProps,
  stateMachine: sfn.StateMachine,
) => {
  const { capitalize } = useCapitalize();

  return new events.Rule(stack, `ScheduleRuleForCreateNewShowNoteStateMachine${capitalize(props.stage)}`, {
    schedule: events.Schedule.expression('cron(0 0 ? * FRI *)'), // 日本時間 金曜 朝9時
    targets: [new targets.SfnStateMachine(stateMachine)],
  });
};
