import { aws_lambda as lambda, Duration } from 'aws-cdk-lib';

import { CdkStack } from '../cdk-stack';
import { StackProps } from '../stack-props';

import { useBuildIamRoleForLambda } from '../utils/useBuildIamRoleForLambda';

import { useCapitalize } from '../utils/useCapitalize';

export const buildCreateNewEpisodeShowNoteLambda = (stack: CdkStack, props: StackProps) => {
  const { capitalize } = useCapitalize();
  const { buildIamRoleForLambda } = useBuildIamRoleForLambda();

  const iamRole = buildIamRoleForLambda(
    stack,
    props,
    `IamRoleForCreateNewEpisodeShowNoteLambda${capitalize(props.stage)}`,
  );

  return new lambda.DockerImageFunction(stack, `CreateNewEpisodeShowNoteLambda${capitalize(props.stage)}`, {
    functionName: `CreateNewEpisodeShowNoteLambda${capitalize(props.stage)}`,
    code: lambda.DockerImageCode.fromImageAsset('./apps/y2bot', {
      cmd: ['app.App::CreateNewEpisodeShowNoteHandler.process'],
      buildArgs: {
        '--platform': 'linux/amd64',
      },
    }),
    timeout: Duration.seconds(30),
    memorySize: 128,
    role: iamRole,
    environment: {
      ENV: props.stage,
      NOTION_API_TOKEN: props.notionApiToken,
      NOTION_SHOW_NOTES_DATABASE_ID: props.notionShowNotesDatabaseId,
    },
  });
};
