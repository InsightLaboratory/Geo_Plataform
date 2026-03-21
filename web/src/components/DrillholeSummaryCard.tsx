import { useEffect, useState } from 'react'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/Card'
import { api } from '@/lib/api'
import type { DrillholeSummary } from '@/types'

interface DrillholeSummaryProps {
  drillholeId: string
  holeName: string
}

export function DrillholeSummaryCard({ drillholeId, holeName }: DrillholeSummaryProps) {
  const [summary, setSummary] = useState<DrillholeSummary | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const fetchSummary = async () => {
      try {
        setLoading(true)
        const data = await api.getDrillholeSummary(drillholeId)
        setSummary(data)
        setError(null)
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Error loading summary')
        console.error('Error fetching summary:', err)
      } finally {
        setLoading(false)
      }
    }

    if (drillholeId) {
      fetchSummary()
    }
  }, [drillholeId])

  if (loading) {
    return (
      <Card>
        <CardHeader>
          <CardTitle className="text-lg">{holeName}</CardTitle>
          <CardDescription>Loading summary...</CardDescription>
        </CardHeader>
      </Card>
    )
  }

  if (error || !summary) {
    return (
      <Card className="border-red-200 dark:border-red-800">
        <CardHeader>
          <CardTitle className="text-lg">{holeName}</CardTitle>
          <CardDescription className="text-red-600 dark:text-red-400">
            {error || 'No data available'}
          </CardDescription>
        </CardHeader>
      </Card>
    )
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-lg">{holeName}</CardTitle>
        <CardDescription>Summary Statistics</CardDescription>
      </CardHeader>
      <CardContent>
        <div className="grid grid-cols-3 gap-4">
          <div className="flex flex-col">
            <span className="text-sm text-slate-500 dark:text-slate-400">Total Samples</span>
            <span className="text-2xl font-bold text-geo-primary">
              {summary.total_samples}
            </span>
          </div>

          <div className="flex flex-col">
            <span className="text-sm text-slate-500 dark:text-slate-400">Avg Au</span>
            <span className="text-2xl font-bold text-geo-accent">
              {summary.avg_au ? summary.avg_au.toFixed(3) : 'N/A'}
            </span>
          </div>

          <div className="flex flex-col">
            <span className="text-sm text-slate-500 dark:text-slate-400">Max Au</span>
            <span className="text-2xl font-bold text-geo-success">
              {summary.max_au ? summary.max_au.toFixed(3) : 'N/A'}
            </span>
          </div>
        </div>
      </CardContent>
    </Card>
  )
}
