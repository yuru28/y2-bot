import { Stack } from 'aws-cdk-lib';
import { Construct } from 'constructs';

import { StackProps } from './stack-props';

import { buildCreateNewShowNoteStateMachine } from './y2bot/buildCreateNewShowNoteStateMachine';
import { buildExecutionRuleForCreateNewShowNoteStateMachine } from './y2bot/buildExecutionRuleForCreateNewShowNoteStateMachine';

export class CdkStack extends Stack {
  constructor(scope: Construct, id: string, props: StackProps) {
    super(scope, id, props);

    const stateMachine = buildCreateNewShowNoteStateMachine(this, props);

    if (props.stage === 'production') {
      buildExecutionRuleForCreateNewShowNoteStateMachine(this, props, stateMachine);
    }
  }
}
