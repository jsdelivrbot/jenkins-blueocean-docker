pipelineJob('Sample-PipelinE') {
    definition {
        cpsscm {
            scm {
                git('https://github.com/projectethan007/petclinic-new.git')
            }
        }
    }
}
