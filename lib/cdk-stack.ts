import { Stack } from 'aws-cdk-lib';
import { Construct } from 'constructs';

import { StackProps } from './stack-props';

import { buildCreateNewShowNoteStateMachine } from './y2bot/buildCreateNewShowNoteStateMachine';

export class CdkStack extends Stack {
  constructor(scope: Construct, id: string, props: StackProps) {
    super(scope, id, props);

    buildCreateNewShowNoteStateMachine(this, props);
  }
}
