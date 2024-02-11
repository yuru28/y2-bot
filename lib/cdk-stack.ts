import { Stack } from 'aws-cdk-lib';
import { Construct } from 'constructs';

import { StackProps } from './stack-props';

import { buildSampleLambda } from './sample/buildSampleLambda';

export class CdkStack extends Stack {
  constructor(scope: Construct, id: string, props: StackProps) {
    super(scope, id, props);

    buildSampleLambda(this, props);
  }
}
