import { aws_iam as iam } from 'aws-cdk-lib';

import { CdkStack } from '../cdk-stack';
import { StackProps } from '../stack-props';

import { useCapitalize } from './useCapitalize';

export const useBuildIamRoleForLambda = () => {
  const { capitalize } = useCapitalize();

  const buildIamRoleForLambda = (stack: CdkStack, props: StackProps, lambdaFunctionName: string) => {
    return new iam.Role(stack, `${capitalize(lambdaFunctionName)}Role${capitalize(props.stage)}`, {
      roleName: `${capitalize(lambdaFunctionName)}Role${capitalize(props.stage)}`,
      assumedBy: new iam.ServicePrincipal('lambda.amazonaws.com'),
      managedPolicies: [
        iam.ManagedPolicy.fromAwsManagedPolicyName('service-role/AWSLambdaBasicExecutionRole'),
        iam.ManagedPolicy.fromAwsManagedPolicyName('AmazonSSMReadOnlyAccess'),
      ],
    });
  };

  return { buildIamRoleForLambda };
};
