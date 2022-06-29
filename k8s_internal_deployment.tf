resource "kubernetes_deployment" "internal_deployment" {
     metadata {
         name = "events-internal-deployment"
         labels = {
            App = "events-internal"
         }
        namespace = kubernetes_namespace.events_ns.metadata[0].name
  }

  spec {
    replicas = 2
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "events-internal"
      }
    }
    template {
      metadata {
        labels = {
          App = "events-internal"
        }
      }
      spec {
        container {
          image = "deepakdinio/devops-bootcamp-internal:1"
          name  = "events-internal"

          env {
            name  = "GOOGLE_CLOUD_PROJECT"
            value = var.project_id
          }
          env {
            name  = "PORT"
            value = 8082
          }
          port {
            container_port = 8082
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}