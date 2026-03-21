import { useState } from 'react'
import { MapPin, TrendingUp, Zap } from 'lucide-react'
import { MapView } from '@/components/MapView'
import { DrillholeSummaryCard } from '@/components/DrillholeSummaryCard'
import { AssayChart } from '@/components/AssayChart'
import { ThemeToggle } from '@/components/ThemeToggle'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/Card'
import type { Drillhole } from '@/types'

export function Explorer() {
  const [selectedDrillhole, setSelectedDrillhole] = useState<Drillhole | null>(null)

  return (
    <div className="min-h-screen bg-slate-50 dark:bg-slate-950 text-slate-950 dark:text-slate-50">
      {/* Header */}
      <header className="border-b border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 shadow-sm sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex items-center justify-between">
          <div className="flex items-center space-x-3">
            <div className="w-10 h-10 bg-gradient-to-br from-geo-primary to-geo-accent rounded-lg flex items-center justify-center">
              <Zap className="w-6 h-6 text-white" />
            </div>
            <div>
              <h1 className="text-2xl font-bold">🌍 GeoPlatform</h1>
              <p className="text-sm text-slate-500 dark:text-slate-400">Mineral Exploration Explorer v3.0</p>
            </div>
          </div>
          <ThemeToggle />
        </div>
      </header>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Map Section */}
          <div className="lg:col-span-2">
            <Card className="h-[600px]">
              <MapView onDrillholeSelect={setSelectedDrillhole} />
            </Card>
            
            {/* Assay Chart */}
            {selectedDrillhole && (
              <div className="mt-6">
                <AssayChart 
                  drillholeId={selectedDrillhole.drillhole_id}
                  holeName={selectedDrillhole.drillhole}
                />
              </div>
            )}
          </div>

          {/* Sidebar */}
          <div className="space-y-6">
            {/* Info Card */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center space-x-2">
                  <MapPin className="w-5 h-5 text-geo-primary" />
                  <span>Explorer Info</span>
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <div>
                  <p className="text-sm text-slate-500 dark:text-slate-400">API Status</p>
                  <p className="font-semibold text-geo-success flex items-center space-x-2">
                    <span className="w-2 h-2 bg-geo-success rounded-full" />
                    <span>Connected</span>
                  </p>
                </div>
                <div>
                  <p className="text-sm text-slate-500 dark:text-slate-400">Database</p>
                  <p className="font-semibold">Supabase PostgreSQL</p>
                </div>
                <div>
                  <p className="text-sm text-slate-500 dark:text-slate-400">Click a marker to view details</p>
                </div>
              </CardContent>
            </Card>

            {/* Selected Drillhole Summary */}
            {selectedDrillhole ? (
              <DrillholeSummaryCard
                drillholeId={selectedDrillhole.drillhole_id}
                holeName={selectedDrillhole.drillhole}
              />
            ) : (
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center space-x-2">
                    <TrendingUp className="w-5 h-5 text-slate-400" />
                    <span>Statistics</span>
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-slate-500 dark:text-slate-400">
                    Click on a drillhole marker to view summary statistics
                  </p>
                </CardContent>
              </Card>
            )}

            {/* Features Card */}
            <Card>
              <CardHeader>
                <CardTitle className="text-base">Features</CardTitle>
              </CardHeader>
              <CardContent className="space-y-2 text-sm">
                <p>✓ Real-time geospatial data</p>
                <p>✓ Drillhole summary statistics</p>
                <p>✓ Au grade analysis</p>
                <p>✓ Dark mode support</p>
                <p>✓ Responsive design</p>
              </CardContent>
            </Card>
          </div>
        </div>
      </main>

      {/* Footer */}
      <footer className="border-t border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 mt-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 text-center text-sm text-slate-500 dark:text-slate-400">
          <p>GEO-PLATFORM v3.0 | Built with React, Vite & Shadcn/ui</p>
        </div>
      </footer>
    </div>
  )
}
